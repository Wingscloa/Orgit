from fastapi import APIRouter, HTTPException
from ..db.session import SessionLocal
from ..services._Group import *
from ..schemas.group import *
from ..services._views import DBallGroupsFromTo, DBsearchGroupByName, DBnearGroup


router = APIRouter()

@router.get('/AllGroupFrTo/{from}/{to}')
async def allGroup(start :int, count: int):

    if(start < 0):
        return HTTPException(status_code=400, detail="Start can't be negative")
    elif count <= 0:
        return HTTPException(status_code=400, detail="Count can't be less or equal to zero")

    db = SessionLocal()

    try:
        result = await DBallGroupsFromTo(start=start,count=count,db=db)
        db.close()

        if not result:
            return HTTPException(status_code=400,detail="Groups doesn't exists")

        return HTTPException(status_code=200, detail=result)
        
    except Exception as err:
        db.close()
        print("Exception Error : ", err)
        return HTTPException(status_code=400, detail="Error contact support")
    

    
# View GroupInNear


@router.delete('/Group')
async def deleteGroup(groupid: int):
    db = SessionLocal()
    
    try:
        response = await DBdeleteGroup(groupid=groupid,db=db)
        db.close()
    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
    
        return HTTPException(status_code=200, detail="Success")
    
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")

@router.get('/GroupInNear/{city}/{start}/{count}')
async def GroupInNear(city : str, start: int, count : int):

    if(start < 0):
        return HTTPException(status_code=400, detail="Start can't be negative")
    elif count <= 0:
        return HTTPException(status_code=400, detail="Count can't be less or equal to zero")

    db = SessionLocal()

    try:
        result = await DBnearGroup(city=city, start=start, count=count, db=db)
        db.close()
        
        if not result:  
            return HTTPException(status_code=400, detail="City doesn't have a group")

        return HTTPException(status_code=200,detail=result)
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail="Contact Support\nException error : {err}")
    
@router.get('/searchGroupByName/{name}/{start}/{count}')
async def searchGroupByName(name: str, start: int, count: int):

    if(start < 0):
        return HTTPException(status_code=400, detail="Start can't be negative")
    elif count <= 0:
        return HTTPException(status_code=400, detail="Count can't be less or equal to zero")

    db = SessionLocal()

    try:
        result = await DBsearchGroupByName(name=name,start=start,count=count,db=db)
        db.close()

        if not result:
            return HTTPException(status_code=400, detail="Group was not found")
        
        return HTTPException(status_code=200, detail=result)
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail="Contact Support\nException error : {err}")


# Group

@router.post('/Group')
async def addGroup(groupModel : GroupCreate):
    db = SessionLocal()

    try:
        await DBcreateGroup(groupModel,db=db)
        return HTTPException(status_code=201, detail="Successfully created")
    except Exception as err:
        db.close()
        print("Exception error : ", err)
        return HTTPException(status_code=400, detail="Parameters are not correct")

@router.get('/GroupById/{groupid}')
async def groupById(groupid:int):
    db = SessionLocal()

    try:
        result = await DBgetGroupById(groupid=groupid,db=db)
        db.close()

        if not result:
            return HTTPException(status_code=400,detail="Group is not found")
        
        return HTTPException(status_code=200, detail=result)
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support\nException error : {err}")

