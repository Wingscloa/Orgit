from fastapi import APIRouter, HTTPException
from session import SessionDep
from services._Title import *
from schemas.title import *


router = APIRouter()

@router.post('/Title')
async def addTitle(titleModel : createTitle, db : SessionDep):
    try:
        await DBtitleCreate(titleModel=titleModel,db=db)
        return HTTPException(status_code=201,detail="Title is created",)
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    finally:
        db.close()


@router.delete('/Title')
async def deleteTitle(titleid: int, db : SessionDep):
    try:
        response = await DBdeleteTitle(titleid=titleid,db=db)
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
        return HTTPException(status_code=200, detail="Success")    
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    finally:
        db.close()

@router.get('/TitleByGroupId/{groupid}')
async def titleByGroupId(groupid : int, db : SessionDep):
    if(groupid <= 0):
                return HTTPException(status_code=400, detail=f"Group doesn't exists")
    try:
        result = await DBgetTitleByGroupId(groupid=groupid, db=db)
        if not result:
            return HTTPException(status_code=400, detail=f"Group doesn't have titles")                
        return HTTPException(status_code=200, detail=result)
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception {err}")
    finally:
        db.close()
    

#includes app default titles and group titles
@router.get('/allTitles/{groupid}')
async def allTitles(groupid: int, db : SessionDep):
    if(groupid <= 0):
        return HTTPException(status_code=400, detail=f"Group doesn't exists")

    try:
        result = await DBgetAllTitles(groupid=groupid,db=db)
        if not result:
            return HTTPException(status_code=400, detail=f"Group doesn't have titles")        
        return HTTPException(status_code=200, detail=result)
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Exception error : {err}")
    finally:
        db.close()
    
@router.post('/titleToUser')
async def titleToUser(model : titleToUser, db : SessionDep):
    try:
        response = await DBtitleToUser(model=model,db=db)
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
        return HTTPException(status_code=200, detail="Success")
    except Exception as err:
        return err
    finally:
        db.close()