from fastapi import FastAPI, HTTPException
from db.session import SessionLocal 
from schemas.users import *
from schemas.group import *
from schemas.group import GroupCreate
from API.services._User import *
from API.services._Group import *
from API.services._views import *
from API.services._Title import *
from API.schemas.title import *
# FastAPI

app = FastAPI()

# User

@app.get('/Users')
async def Users():
    db = SessionLocal()

    try:
        response = await DBgetUsers(db)
        db.close()
        return HTTPException(status_code=200,detail=response)
    except NameError:
        db.close()
        return HTTPException(status_code=500,detail="Internal Server Error ${NameError}")

@app.post('/User')
async def addUser(userModel : UserCreate):
    db = SessionLocal()

    try:
        await DBcreateUser(userModel,db=db)
        db.close()
        return HTTPException(status_code=201, detail="Successfully created")
    except NameError:
        db.close()
        return HTTPException(status_code=400, detail="Parameters are not correct")     


@app.get('/userById/{userid}')
async def userById(userid: int):
    db = SessionLocal()
    try:
        result = await DBgetUserById(userid=userid,db=db)
        db.close()

        if not result:
            return HTTPException(status_code=404,detail=f"User not found",headers=False)
        
        return HTTPException(status_code=200,detail=result)

    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception Error {err}")




# Check Email

@app.get('/EmailExists/{email}')
async def EmailExist(email: str):

    db = SessionLocal()

    try:
        result = await DBemailExists(email=email,db=db)
        db.close()

        if not result:
            return HTTPException(status_code=404,detail=False,headers="Doesn't exists") 

        return HTTPException(status_code=200,detail=True, headers="Email is already in Database")
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception Error {err}")

    
# VIEW AllGroup

@app.get('/AllGroupFrTo/{from}/{to}')
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

@app.get('/GroupInNear/{city}/{start}/{count}')
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
    
@app.get('/searchGroupByName/{name}/{start}/{count}')
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

@app.post('/Group')
async def addGroup(groupModel : GroupCreate):
    db = SessionLocal()

    try:
        await DBcreateGroup(groupModel,db=db)
        return HTTPException(status_code=201, detail="Successfully created")
    except Exception as err:
        db.close()
        print("Exception error : ", err)
        return HTTPException(status_code=400, detail="Parameters are not correct")

@app.get('/GroupById/{groupid}')
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

# Titles

@app.post('/Title')
async def addTitle(titleModel : createTitle):
    db = SessionLocal()

    try:
        await DBtitleCreate(titleModel=titleModel,db=db)
        db.close()
        return HTTPException(status_code=201,detail="Title is created",)
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")

@app.get('/TitleByGroupId/{groupid}')
async def titleByGroupId(groupid : int):

    if(groupid <= 0):
        return HTTPException(status_code=400, detail=f"Group doesn't exists")

    db = SessionLocal()

    if not await DBdoesExistGroup(groupid=groupid,db=db):
        return HTTPException(status_code=400, detail=f"Group doesn't exist")

    try:
        result = await DBgetTitleByGroupId(groupid=groupid, db=db)
        db.close()

        if not result:
            return HTTPException(status_code=400, detail=f"Group doesn't have titles or exists")
        
        return HTTPException(status_code=200, detail=result)
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception {err}")

#includes app default titles and group titles
@app.get('/allTitles/{groupid}')
async def allTitles(groupid: int):

    if(groupid <= 0):
        return HTTPException(status_code=400, detail=f"Group doesn't exists")
    
    db = SessionLocal()

    if not await DBdoesExistGroup(groupid=groupid,db=db):
        return HTTPException(status_code=400, detail=f"Group doesn't exist")
    
    try:
        result = await DBgetAllTitles(groupid=groupid,db=db)
        db.close()
        if not result:
            return HTTPException(status_code=400, detail=f"Contact support - Titles (400)")
        
        return HTTPException(status_code=200, detail=result)
    except Exception as err:
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")

# TODO : Resit views pro specificky tasks