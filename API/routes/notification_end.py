from fastapi import HTTPException, APIRouter
from db.session import SessionLocal
from schemas.notifications import *
from services._notifications import *


router = APIRouter()

@router.post('/Notification')
async def createNofication(model: createNotification):
    db = SessionLocal()
    
    try:
        response = await DBcreateNotification(model=model,db=db)
        db.close()
    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
    
        return HTTPException(status_code=200, detail="Success")
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    
@router.delete('/Notification')
async def deleteNotification(notify: int):
    db = SessionLocal()
    
    try:
        response = await DBdeleteNotification(NotifyId=notify,db=db)
        db.close()
    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
    
        return HTTPException(status_code=200, detail="Success")
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    
@router.put('/Notification')
async def updateNotification(model : updateNotification):
    db = SessionLocal()
    
    try:
        response = await DBupdateNotification(model=model,db=db)
        db.close()
    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
    
        return HTTPException(status_code=200, detail="Success")
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")

@router.get('/Notification')
async def getNotification(userid:int):
    db = SessionLocal()
    
    try:
        response = await DBgetNotificationUser(userid=userid,db=db)
        db.close()
    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
    
        return HTTPException(status_code=200, detail=response)
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")