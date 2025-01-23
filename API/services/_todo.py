from ..schemas.todo import *
from ..db.models.users import User
from ..db.models.toDo import ToDo
from sqlalchemy.orm import Session
from fastapi import HTTPException

async def DBcreateToDo(model : ToDoCreate, db : Session):
    try:
        newTodo = ToDo(**model.model_dump())

        db.add(newTodo)
        db.commit()
        db.flush()
        db.refresh(newTodo)
        raise HTTPException(status_code=201, detail="ToDo is created")
    except Exception as err:
        raise Exception(err)

async def DBUpdateTodo(model : ToDoUpdate, db : Session):
    _current = (db.query(ToDo)
                .filter(ToDo.todoid == model.todoid)
                .first())
    
    if not _current:
        return False
    
    _current.thing = model.thing
    _current.note = model.note
    _current.tocomplete = model.tocomplete

    db.commit()
    db.flush()

    db.refresh(_current)

    return True


async def DBgetToDoUser(userid: int, db: Session):
    result = (db.query(ToDo)
            .filter(ToDo.userid == userid)
            .all()) # userTodo
    db.flush()
    
    if not result:
        return False
    
    return result

async def DBdeleteTodo(TodoInt: int, db : Session):
    _toDelete = (db.query(ToDo)
                 .filter(ToDo.todoid == TodoInt)
                 .first())    

    if not _toDelete:
        db.flush()
        return False
    
    db.delete(_toDelete)
    db.flush()
    db.commit()

    return True
