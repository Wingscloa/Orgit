from fastapi import HTTPException, APIRouter
from session import SessionDep
from schemas.notifications import *
from services._notifications import *

router = APIRouter()

@router.post('/Notification')
async def createNofication(model: createNotification, db : SessionDep):
    try:
        response = await DBcreateNotification(model=model,db=db)
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
        return HTTPException(status_code=200, detail="Success")
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    finally:
        db.close()

@router.delete('/Notification')
async def deleteNotification(notify: int, db : SessionDep):    
    try:
        response = await DBdeleteNotification(NotifyId=notify,db=db)    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
        return HTTPException(status_code=200, detail="Success")
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    finally:
        db.close()

@router.put('/Notification')
async def updateNotification(model : updateNotification, db : SessionDep):
    try:
        response = await DBupdateNotification(model=model,db=db)
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
        return HTTPException(status_code=200, detail="Success")
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    finally:
        db.close()

@router.get('/Notification')
async def getNotification(userid:int, db : SessionDep):
    try:
        response = await DBgetNotificationUser(userid=userid,db=db)
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
        return HTTPException(status_code=200, detail=response)
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    finally:
        db.close()