from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime

class ToDo(BaseModel):
    todoid : int
    userid : int
    title : str = Field(min_length=1,max_length=32)
    note : Optional[str] = Field(min_length=1, max_length=255,)
    whencomplete : datetime
    tocomplete : Optional[datetime] 
    completed : bool = Field(default=False)
    createdat : datetime
    music : str = Field(min_length=1, max_length=16, default='joy')

class ToDoResponse(BaseModel):
    userid : int
    title : str = Field(min_length=1,max_length=32)
    note : Optional[str] = Field(min_length=1, max_length=255,)
    whencomplete : datetime
    tocomplete : Optional[datetime] 
    completed : bool = Field(default=False)
    createdat : datetime
    music : str = Field(min_length=1, max_length=16, default='joy')

class ToDoCreate(BaseModel):
    userid : int
    title : str = Field(min_length=1, max_length=32)
    note : Optional[str] = Field(max_length=255)
    whencomplete : datetime
    tocomplete : Optional[datetime]

class ToDoUpdate(BaseModel):
    todoid:int
    title : str = Field(min_length=1, max_length=32)
    note : str = Field(max_length=255)
    whencomplete : datetime
    tocomplete : datetime