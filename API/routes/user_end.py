from fastapi import APIRouter, HTTPException
from ..db.session import SessionLocal
from ..services._User import *
from ..schemas.users import *
from ..services._exists import *


router = APIRouter()

@router.get('/User')
async def Users():
    db = SessionLocal()

    try:
        response = await DBgetUsers(db)
        db.close()
        return HTTPException(status_code=200,detail=response)
    except NameError:
        db.close()
        return HTTPException(status_code=500,detail="Internal Server Error ${NameError}")
    

@router.post('/User')
async def addUser(userModel : UserCreate):
    db = SessionLocal()

    try:
        await DBcreateUser(userModel,db=db)
        db.close()
        return HTTPException(status_code=201, detail="Successfully created")
    except NameError:
        db.close()
        return HTTPException(status_code=400, detail="Parameters are not correct")     

@router.put('/User')
async def CreateProfile(model : CreateProfileForm):
    db = SessionLocal()

    try:
        response = await DBCreateProfileForm(model=model, db=db)
        db.close()
        if not response:
            return HTTPException(status_code=404,detail="User is not found")
        
        return HTTPException(status_code=200, detail="User is changed")
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception Error {err}")

@router.put('/UserAdmin')
async def deleteUser(model : DeleteUser):
    db = SessionLocal()

    try:
        response = await DBdeleteUser(model=model,db=db)
        if not response:
            return HTTPException(status_code=404,detail="User is not found")
        
        return HTTPException(status_code=200,detail="User is changed")
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception Error {err}")


@router.get('/UserByUId/{useruid}')
async def userByUid(useruid: str):
    db = SessionLocal()

    try:
        result = await DBgetUserByUid(useruid=useruid,db=db)
        db.close()

        if not result:
            return HTTPException(status_code=404,detail=f"User not found",headers=False)
        
        return HTTPException(status_code=200,detail=result)

    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception Error {err}")


@router.post('/UserToGroup')
async def userToGroup(model: userToGroup):
    db = SessionLocal()

    try:
        response = await DBuserToGroup(model=model, db=db)
        db.close()
        
        return HTTPException(status_code=200, detail="Success")
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
    

@router.post('/UserToEvent')
async def userToEvent(model: sch_userToEvent):
    db = SessionLocal()
    
    try:
        response = await DBuserToEvent(model=model,db=db)
        db.close()
    
        if not response:
            return HTTPException(status_code=404, detail="Not Found")
    
        return HTTPException(status_code=200, detail="Success")
    
    except Exception as err:
        return HTTPException(status_code=404, detail=f"{err}")
    
