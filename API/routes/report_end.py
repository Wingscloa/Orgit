from fastapi import HTTPException, APIRouter
from session import SessionDep
from schemas.reports import *
from services._reports import *

router = APIRouter()

@router.get('/Report')
async def getReport(userid: int, db : SessionDep):        
    try:
        response = await DBgetReport(userid=userid,db=db)
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
        return HTTPException(status_code=200, detail=response)
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    finally:
        db.close()

@router.delete('/Report')
async def deleteReport(reportid: int, db : SessionDep):    
    try:
        response = await DBdeleteReport(reportid=reportid,db=db)
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
        return HTTPException(status_code=200, detail="Success")
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    finally:
        db.close()

@router.post('/Report')
async def createReport(model : CreateReport, db : SessionDep):    
    try:
        response = await DBCreateReport(model=model,db=db)
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
        return HTTPException(status_code=200, detail="Success")
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    finally:
        db.close()