from fastapi import APIRouter, HTTPException
from ..db.session import SessionLocal
from ..services._Title import *
from ..schemas.title import *


router = APIRouter()


@router.post('/Title')
async def addTitle(titleModel : createTitle):
    db = SessionLocal()

    try:
        await DBtitleCreate(titleModel=titleModel,db=db)
        db.close()
        return HTTPException(status_code=201,detail="Title is created",)
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")


@router.delete('/Title')
async def deleteTitle(titleid: int):
    db = SessionLocal()
    
    try:
        response = await DBdeleteTitle(titleid=titleid,db=db)
        db.close()
    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
    
        return HTTPException(status_code=200, detail="Success")
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")

@router.get('/TitleByGroupId/{groupid}')
async def titleByGroupId(groupid : int):

    if(groupid <= 0):
        return HTTPException(status_code=400, detail=f"Group doesn't exists")

    db = SessionLocal()

    try:
        result = await DBgetTitleByGroupId(groupid=groupid, db=db)

        if not result:
            return HTTPException(status_code=400, detail=f"Group doesn't have titles")
        
        db.close()
        
        return HTTPException(status_code=200, detail=result)
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception {err}")

#includes app default titles and group titles
@router.get('/allTitles/{groupid}')
async def allTitles(groupid: int):

    if(groupid <= 0):
        return HTTPException(status_code=400, detail=f"Group doesn't exists")
    
    db = SessionLocal()

    try:
        result = await DBgetAllTitles(groupid=groupid,db=db)
        db.close()

        if not result:
            return HTTPException(status_code=400, detail=f"Group doesn't have titles")
        
        return HTTPException(status_code=200, detail=result)
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Exception error : {err}")
    
@router.post('/titleToUser')
async def titleToUser(model : titleToUser):
    db = SessionLocal()
    
    try:
        response = await DBtitleToUser(model=model,db=db)
        db.close()
    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
    
        return HTTPException(status_code=200, detail="Success")
    
    except Exception as err:
        return err
