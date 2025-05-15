from schemas.notifications import *
from db.models.users import User
from db.models.notifications import Notification
from sqlalchemy.orm import Session
from session import getDb
from fastapi import Depends

async def DBcreateNotification(model : createNotification, db : Session = Depends(getDb)):
    newNotify = Notification(**model.model_dump())

    db.add(newNotify)
    db.flush()
    db.commit()
    db.refresh(newNotify)
    return True


async def DBupdateNotification(model: updateNotification, db : Session = Depends(getDb)):
    _old = (db.query(Notification)
            .filter(Notification.notificationid == model.notificationid)
            .first())
    
    _old.notificationtypeid = model.notificationtypeid
    _old.message = model.message

    db.flush()
    db.commit()
    db.refresh(_old)



async def DBgetNotificationUser(userid: int, db : Session = Depends(getDb)):
    result = (db.query(Notification)
            .filter(Notification.userid == userid)
            .all()) # userTodo
    db.flush()
    
    if not result:
        return False
    
    return result

async def DBdeleteNotification(NotifyId: int, db : Session = Depends(getDb)):
    _toDelete = (db.query(Notification)
                 .filter(Notification.notificationid == NotifyId)
                 .first())    

    if not _toDelete:
        db.flush()
        return False
    
    db.delete(_toDelete)
    db.flush()
    db.commit()

    return True
