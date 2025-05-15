from pydantic import BaseModel, Field
from datetime import datetime

class GroupSchema(BaseModel):
    profilepicture : str #base64
    name : str = Field(min_length=1,max_length=32)
    city : str = Field(min_length=1,max_length=32)
    region : str = Field(min_length=1,max_length=32)
    leader : int = Field(gt=0)
    description : str = Field(min_length=1,max_length=512)
    createdby : int = Field(gt=0)

class GroupResponse(BaseModel):
    profilepicture : str
    name : str = Field(min_length=1,max_length=32)
    city : str = Field(min_length=1,max_length=32)
    region : str = Field(min_length=1,max_length=32)
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
    city : str = Field(min_length=1,max_length=32) 