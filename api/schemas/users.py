from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime

class UserResponse(BaseModel):
    userid : Optional[int]
    useruid : Optional[str]
    firstname : Optional[str]
    lastname : Optional[str]
    nickname : Optional[str]
    email : Optional[str]
    birthday : Optional[datetime]
    verified : Optional[bool]
    deleted : Optional[bool]
    telephonenumber : Optional[str]
    telephoneprefix: Optional[str]
    level : Optional[int]
    experience : Optional[int]
    profileicon : Optional[str]
    deletedat : Optional[datetime]
    createdat : Optional[datetime]
    lastactive : Optional[datetime]

class RegisterSchema(BaseModel):
    useruid : str   
    email: EmailStr

class ProfileSchema(BaseModel):
    useruid : str
    firstname : str = Field(min_length=1, max_length=32)
    lastname : str = Field(min_length=1, max_length=32)
    nickname : str = Field(max_length=32)
    telephoneprefix: str = Field(max_length=3, min_length=3)
    telephonenumber: str = Field(max_length=9, min_length=9)
    birthday : datetime
    profileicon : Optional[str] = None  # Base64 encoded string

class VerifySchema(BaseModel):
    useruid : str

class UserEventSchema(BaseModel):
    useruid : int
    eventid: int

class UserLevelUpSchema(BaseModel):
    useruid : str
    level : int = Field(ge=1)

class UserExperienceSchema(BaseModel):
    useruid : str
    experience : int = Field(ge=0)

class UserProfileSchema(BaseModel):
    useruid : str
    ProfileIcon : Optional[str] = None  # Base64 encoded string

class UserGroupSchema(BaseModel):
    useruid : str
    groupid : int
