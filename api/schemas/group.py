from pydantic import BaseModel, Field
from datetime import datetime

class GroupSchema(BaseModel):
    profilepicture : str #base64
    name : str = Field(min_length=1,max_length=32)
    city : int = Field(gt=0)
    region : int = Field(gt=0)
    leader : int = Field(gt=0)
    description : str = Field(min_length=1,max_length=512)
    createdby : int = Field(gt=0)

class GroupResponse(BaseModel):
    profilepicture : str
    name : str = Field(min_length=1,max_length=32)
    city : int = Field(gt=0)
    region : int = Field(gt=0)
    city_name : str = Field(min_length=1,max_length=32)  # název města z relationship
    region_name : str = Field(min_length=1,max_length=32)  # název regionu z relationship
    leader : int = Field(gt=0)
    description : str = Field(min_length=1,max_length=512)
    createdby : int = Field(gt=0)
    createdat : datetime
    deleted : bool

    class Config:
        from_attributes = True

class GroupSearchResponse(BaseModel):
    groupid : int = Field(gt=0)
    name : str = Field(min_length=1,max_length=32)
    profilepicture : str
    city_name : str = Field(min_length=1,max_length=32)  # název města

class GroupMemberSchema(BaseModel):
    userid: int = Field(gt=0)
    groupid: int = Field(gt=0)

class GroupMemberResponse(BaseModel):
    message: str
    status: str