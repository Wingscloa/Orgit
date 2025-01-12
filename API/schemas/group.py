from pydantic import BaseModel
from datetime import date, datetime

class GroupCreate(BaseModel):
    profilepic: bytes
    name : str
    city : str
    leader : int
    description : str
    createdby : int
    createdat : datetime
