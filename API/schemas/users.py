from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime
import base64

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

    class Config:
        json_encoders = {
            bytes: lambda v: base64.b64encode(v).decode('utf-8'),
        }

class CreateProfileForm(BaseModel):
    useruid: str
    firstname: str
    lastname: str
    nickname: str
    profileicon: bytes
    telephoneprefix: str
    telephonenumber: str
    birthday : datetime

    class Config:
        json_encoders = {
            bytes: lambda v: base64.b64encode(v).decode('utf-8'),
        }

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

