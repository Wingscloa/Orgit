from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

class UserCreate(BaseModel):
    useruid: str
    firstname: str
    lastname: str
    nickname: str
    email: EmailStr
    profileicon: bytes
    telephoneprefix: str
    telephonenumber: str
    lastactive : datetime
    birthday : datetime

class UpdateUserForm(BaseModel):
    userid : int
    firstname : str
    lastname : str
    nickname : str
    birthday : datetime
    telephonenumber: str

class sch_userToEvent(BaseModel):
    eventid: int
    userid : int
class DeleteUser(BaseModel):
    userid : int
    deleted : bool
    deletedat : datetime
    # lastactive == deletedat

class UserResponse(BaseModel):
    userid: int
    useruid: str
    firstname: str
    lastname: str
    nickname: Optional[str]
    email: EmailStr
    profileicon: Optional[bytes]
    deleted: bool
    deletedat: Optional[datetime]
    createdat: Optional[datetime]
    lastactive: datetime 
    telephonenumber: Optional[str]
    telephoneprefix: Optional[str]
    level: int
    experience: int
    settingsconfig: Optional[bytes]

    class Config:
        from_attributes = True

class userToGroup(BaseModel):
    userid : int
    groupid: int

