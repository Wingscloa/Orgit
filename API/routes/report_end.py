from fastapi import HTTPException, APIRouter
from db.session import SessionLocal
from schemas.reports import *
from services._reports import *

router = APIRouter()

@router.get('/Report')
async def getReport(userid: int):
    db = SessionLocal()
        
    try:
        response = await DBgetReport(userid=userid,db=db)
        db.close()
    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
    
        return HTTPException(status_code=200, detail=response)
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    
@router.delete('/Report')
async def deleteReport(reportid: int):
    db = SessionLocal()
    
    try:
        response = await DBdeleteReport(reportid=reportid,db=db)
        db.close()
    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
    
        return HTTPException(status_code=200, detail="Success")
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    
@router.post('/Report')
async def createReport(model : CreateReport):
    db = SessionLocal()
    
    try:
        response = await DBCreateReport(model=model,db=db)
        db.close()
    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
    
        return HTTPException(status_code=200, detail="Success")
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
