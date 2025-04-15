from fastapi import APIRouter, HTTPException
from session import SessionDep
from services._views import *

router = APIRouter()

@router.get('/EmailExists/{email}')
async def EmailExist(email: str, db : SessionDep):
    try:
        result = await DBemailExists(email=email,db=db)
        if not result:
            return HTTPException(status_code=404,detail=False,headers="Doesn't exists") 
        return HTTPException(status_code=200,detail=True, headers="Email is already in Database")
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception Error {err}")
    finally:
        db.close()