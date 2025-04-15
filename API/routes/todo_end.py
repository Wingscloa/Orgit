from fastapi import APIRouter, HTTPException, Depends
from fastapi.responses import JSONResponse
from schemas.todo import *
from services._todo import *
from session import getDb
from auth import verify_firebase_token

router = APIRouter()

@router.get('/Todo/{userid}', response_model=ToDoResponse)
async def get_todo_by_userid(userid: int, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        userExist = db.query(User).filter(User.userid == userid).first()
        if not userExist:
            return JSONResponse(status=404,content=False,headers="User doesn't exist")   
        response = DBgetToDoUser(userid,db)
        if not response:
            return JSONResponse(status_code=404, detail=False, headers="User doesn't have todos")
        return response        
    except Exception as err:
        raise HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")

@router.post('/Todo')
async def create_todo(model : ToDoCreate, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        response = DBcreateToDo(model,db)
        return JSONResponse(status_code=200,content="Todo is created")
    except Exception as err:
        raise HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")

@router.delete('/Todo/{Id}')
async def delete_Todo_by_id(Id: int, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        response = DBdeleteTodo(TodoId, db)
        if not response:
            return JSONResponse(status_code=404,content=False,headers="Something want wrong")
        return JSONResponse(status_code=201,content=True,headers="Todo is deleted")
    except Exception as err:
        raise HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")

@router.put('/Todo')
async def put_update_todo(model : ToDoUpdate, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        response = DBUpdateTodo(model=model,db=db)
        if not response:
            return JSONResponse(status_code=404,content=False,headers="Something want wrong")        
        return JSONResponse(status_code=201, content="ToDo is changed")
    except Exception as err:
        raise HTTPException(status_code=400,detail=f"Contact support - Exception error : {err}")
    
@router.put('/Todo/{id}')
async def put_complete_todo_by_id(id : int, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        response = DBcompleteTodo(TodoId,db)
        if not response:
            return JSONResponse(status_code=404, content=False, headers="Something want wrong")
        return JSONResponse(status_code=201,content=True, headers="ToDo is completed")
    except Exception as err:
        raise HTTPException(status_code=400,detail=f"Contact support - Exception error : {err}")