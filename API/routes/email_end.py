from fastapi import APIRouter, HTTPException
from services._views import *
from fastapi import APIRouter, HTTPException, Depends
from fastapi.responses import JSONResponse
from services._User import *
from schemas.users import *

router = APIRouter()

@router.get('/email/',)
async def get_email_exists(email : str,db : Session = Depends(getDb)):
    try:
        response = email_exists(email, db)
        return response
    except HTTPException as err:
        raise HTTPException(status_code=500, detail=f"{err}")
