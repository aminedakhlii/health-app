from datetime import datetime
from pydantic import BaseModel
from typing import List, Optional
import uuid
from src.schema.fitBitData import FitBitData


class Message(BaseModel):
    id = uuid.uuid4()
    msg: str
    timestamp = str(datetime.now())


class Chat(BaseModel):
    token: str
    messages: List[Message]
    name: str
    session_start = str(datetime.now())
    fitbit_data: FitBitData
    