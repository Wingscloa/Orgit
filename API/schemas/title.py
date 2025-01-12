from pydantic import BaseModel
from typing import Optional

class createTitle(BaseModel):
    name : str
    color : str
    categoryid : Optional[int] = 1
    levelreq : Optional[int] = 0
    appdefault : Optional[bool] = False
    description : str
    icon : int = 1


