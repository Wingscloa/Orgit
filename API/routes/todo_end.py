from fastapi import APIRouter, HTTPException
from ..schemas.todo import *
from ..services._todo import *
from ..db.session import SessionLocal


router = APIRouter()

@router.post('/Todo')
async def createTodo(model : ToDoCreate):
    db = SessionLocal()

    try:
        result = await DBcreateToDo(model=model,db=db)
        db.close()
        return HTTPException(status_code=200, detail="ToDo is created")
        
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")

@router.get('/Todo')
async def getTodo(userid: int):
    db = SessionLocal()

    userExist = db.query(User).filter(User.userid == userid).first()

    if not userExist:
        return HTTPException(status_code=400,detail="User doesn't exists")

    try:
        result = await DBgetToDoUser(userid=userid,db=db)
        db.close()

        if not result:
            return HTTPException(status_code=404, detail="User doesn't have todos", headers=False)

        return HTTPException(status_code=200, detail=result)
    
    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")


@router.put('/TodoDelete')
async def DeleteTodo(TodoId:int):
    db = SessionLocal()

    try:
        response = await DBdeleteTodo(TodoInt=TodoId, db=db)
        db.close()

        if not response:
            return HTTPException(status_code=404, detail="Todo not found")
        
        return HTTPException(status_code=200, detail="ToDo is deleted")

    except Exception as err:
        db.close()
        return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")

@router.put('/Todo')
async def changeTodo(model : ToDoUpdate):
    db = SessionLocal()

    try:
        response = await DBUpdateTodo(model=model,db=db)
        db.close()

        if not response:
            return HTTPException(status_code=404, detail="Todo not found")
        
        return HTTPException(status_code=200, detail="ToDo is changed")

    except Exception as err:
        db.close()
        return HTTPException(status_code=400,detail=f"Contact support - Exception error : {err}")
