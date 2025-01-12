from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class ToDoCreate(BaseModel):
    userid : int
    thing : str
    note : Optional[str]
    tocomplete : datetime

class ToDoUpdate(BaseModel):
    todoid:int
    thing : str
    note : Optional[str]
    tocomplete : datetime