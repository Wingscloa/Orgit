from pydantic import BaseModel, Field

class CitySchema(BaseModel):
    name: str = Field(min_length=1, max_length=32)
    regionid: int = Field(gt=0)

class CityResponse(BaseModel):
    cityid: int = Field(gt=0)
    name: str = Field(min_length=1, max_length=32)
    regionid: int = Field(gt=0)
    region_name: str = Field(min_length=1, max_length=32)

    class Config:
        from_attributes = True

class RegionSchema(BaseModel):
    name: str = Field(min_length=1, max_length=32)

class RegionResponse(BaseModel):
    regionid: int = Field(gt=0)
    name: str = Field(min_length=1, max_length=32)

    class Config:
        from_attributes = True
