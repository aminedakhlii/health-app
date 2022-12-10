from src.redis.config import Redis
import asyncio
from src.redis.cache import Cache
from src.chatbot_project.chatbot import AIModel
from src.schema.chat import Message
from src.redis.stream import StreamConsumer
from src.redis.producer import Producer


redis = Redis()
async def main():
    json_client = redis.create_rejson_connection()
    redis_client = await redis.create_connection()
    consumer = StreamConsumer(redis_client)
    cache = Cache(json_client)
    producer = Producer(redis_client)

    print("Stream consumer started")
    print("Stream waiting for new messages")

    while True:
        response = await consumer.consume_stream(stream_channel="message_channel", count=1, block=0)
        if response:
            for stream, messages in response:
                # Get message from stream, and extract token, message data and message id
                for message in messages:
                    message_id = message[0]
                    token = [k.decode('utf-8')
                             for k, v in message[1].items()][0]
                    message = [v.decode('utf-8')
                               for k, v in message[1].items()][0]
                    print(token)

                    # Create a new message instance and add to cache, specifying the source as human
                    msg = Message(msg=message)
                    await cache.add_message_to_cache(token=token, source="human", message_data=msg.dict())

                    # Get chat history from cache
                    data = await cache.get_chat_history(token=token)

                    # Clean message input and send to query
                    message_data = data['messages'][-4:]
                    last_message = message_data[-1]['msg']
                    last_message = last_message.replace("Human: ", "")
                    res = await AIModel().queryAI(last_message)
                    msg = Message(
                        msg=res
                    )
                    print(msg)

                    stream_data = {}
                    stream_data[str(token)] = str(msg.dict())
                    
                    await producer.add_to_stream(stream_data, "response_channel")

                    await cache.add_message_to_cache(token=token, source="bot", message_data=msg.dict())

                # Delete messaage from queue after it has been processed

                await consumer.delete_message(stream_channel="message_channel", message_id=message_id)

if __name__ == "__main__":
    asyncio.run(main())

