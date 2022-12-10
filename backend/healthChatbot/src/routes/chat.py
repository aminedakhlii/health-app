from fastapi import APIRouter, Depends, FastAPI, WebSocket,  Request,HTTPException, WebSocketDisconnect
import uuid
from rejson import Path
import sys
sys.path.append("..")
from src.socketConnection.utils import get_token
from src.socketConnection.connection import ConnectionManager
from src.redisManager.producer import Producer
from src.redisManager.config import Redis
from src.schema.chatMessage import Chat, Message
from src.redisManager.stream import StreamConsumer
from src.redisManager.cache import Cache
from src.schema.fitBitData import FitBitData

chat = APIRouter()
manager = ConnectionManager()
redis = Redis()

# @route   POST /token
# @desc    Route to generate chat token
# @access  Public

@chat.post("/token")
async def token_generator(name: str,request: Request):
    if name == "":
        raise HTTPException(status_code=400, detail={
            "loc": "name",  "msg": "Enter a valid name"})
    token = str(uuid.uuid4())
    
    # Create new chat session
    json_client = redis.create_rejson_connection()
    chat_session = Chat(
        token=token,
        messages=[],
        name=name,
        fitbit_data=FitBitData(heartRate=[80,80,90])
    )
    json_client.jsonset(str(token), Path.rootPath(), chat_session.dict())
    
    # Set a timeout for redis data
    redis_client = await redis.create_connection()
    await redis_client.expire(str(token), 2592000) # 30 days

    return chat_session.dict()

# @route   POST /refresh_token
# @desc    Route to refresh token
# @access  Public

@chat.post("/refresh_token")
async def refresh_token(request: Request,token : str):
    json_client = redis.create_rejson_connection()
    cache = Cache(json_client)
    data = await cache.get_chat_history(token)
    
    if data == None:
        raise HTTPException(
            status_code=400, detail="Session expired or does not exist")
    else:
        return data



# @route   Websocket /chat
# @desc    Socket for chatbot
# @access  Public

@chat.websocket("/chat")
async def websocket_endpoint(websocket: WebSocket, token: str = Depends(get_token)):
    await manager.connect(websocket)
    redis_client = await redis.create_connection()
    producer = Producer(redis_client)
    json_client = redis.create_rejson_connection()
    consumer = StreamConsumer(redis_client)
    try:
        while True:
            data = await websocket.receive_text()
            print(data)
            stream_data = {}
            stream_data[token] = data
            await producer.add_to_stream(stream_data, "message_channel")
            #get response from AI
            response = await consumer.consume_stream(stream_channel="response_channel", block=0)

            print(response)
            #find channel with correct token
            for stream, messages in response:
                for message in messages:
                    response_token = [k.decode('utf-8') for k, v in message[1].items()][0]
                    if token == response_token:
                        response_message = [v.decode('utf-8') for k, v in message[1].items()][0]
                        print(message[0].decode('utf-8'))
                        print(token)
                        print(response_token)
                        #send message to websocket
                        await manager.send_personal_message(response_message, websocket)
                    
                    await consumer.delete_message(stream_channel="response_channel", message_id=message[0].decode('utf-8'))
    except WebSocketDisconnect:
        manager.disconnect(websocket)