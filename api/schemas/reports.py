from pydantic import BaseModel

class CreateReport(BaseModel):
    userid: int
    thing : str
    note : str