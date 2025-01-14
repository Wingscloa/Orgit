from pydantic import BaseModel
from datetime import date, datetime

class GroupCreate(BaseModel):
    profilepic: bytes
    name : str
    city : str
    region : str
    leader : int
    description : str
    createdby : int
    createdat : datetime

