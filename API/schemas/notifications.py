from pydantic import BaseModel

class createNotification(BaseModel):
    userid: int
    notificationtypeid: int
    message: str

class updateNotification(BaseModel):
    notificationid: int
    notificationtypeid: int
    message: str