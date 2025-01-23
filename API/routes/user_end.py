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
        return HTTPException(status_code=200, detail=response)

    except NameError as err:
        db.close()
        return HTTPException(status_code=500, detail=f"{err}")
    
    except HTTPException as err:
        db.close()
        return err
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=500, detail=f"{err}")
    

@router.post('/User')
async def addUser(userModel : UserCreate):
    db = SessionLocal()

    try:
        await DBcreateUser(userModel,db=db)
        db.close()

    except NameError as err:
        db.close()
        return HTTPException(status_code=400, detail=f"{err}")
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=500, detail=f"{err}")

@router.put('/User')
async def CreateProfile(model : CreateProfileForm):
    db = SessionLocal()

    try:
        response = await DBCreateProfileForm(model=model, db=db)
        db.close()   
        return HTTPException(status_code=201, detail=f"{response}")  
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"{err}")
    except HTTPException as err:
        db.close()
        return err
    except NameError as err:
        db.close()
        return HTTPException(status_code=500, detail=f"{err}")

@router.put('/UserAdmin')
async def deleteUser(model : DeleteUser):
    db = SessionLocal()

    try:
        response = await DBdeleteUser(model=model,db=db)
        db.close()
        return HTTPException(status_code=201, detail=f"{response}")
    except Exception as err:
        db.close()
        return HTTPException(status_code=500, detail=f"{err}")
    except NameError as err:
        db.close()
        return HTTPException(status_code=500, detail=f"{err}")


@router.get('/UserByUId/{useruid}')
async def userByUid(useruid: str):
    db = SessionLocal()

    try:
        response = await DBgetUserByUid(useruid=useruid,db=db)
        db.close()
        return HTTPException(status_code=200,detail=f"{response}")
    except Exception as err:
        db.close()
        return HTTPException(status_code=500, detail=f"{err}")
    except HTTPException as err:
        db.close()
        return err
    except NameError as err:
        db.close()
        return HTTPException(status_code=500, detail=f"{err}")


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
    
