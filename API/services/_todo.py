from schemas.todo import *
from db.models.users import User
from db.models.toDo import ToDo
from sqlalchemy.orm import Session
from fastapi import HTTPException

def DBcreateToDo(model : ToDoCreate, db : Session):
    try:
        newTodo = ToDo(**model.model_dump())
        db.add(newTodo)
        db.commit()
    except Exception as err:
        raise err

def DBUpdateTodo(model : ToDoUpdate, db : Session):
    _current = (db.query(ToDo)
                .filter(ToDo.todoid == model.todoid)
                .first())
    if not _current:
        return False
    db.commit()
    return True


def DBgetToDoUser(userid: int, db: Session):
    result = (db.query(ToDo)
            .filter(ToDo.userid == userid)
            .all()) # userTodo        
    return result

def DBdeleteTodo(TodoId: int, db : Session):
    _toDelete = (db.query(ToDo)
                 .filter(ToDo.todoid == TodoId)
                 .first())    
    if not _toDelete:
        return False
    db.delete(_toDelete)
    db.commit()

def DBcompleteTodo(TodoId : int, db : Session):
    toComplete = (db.query(ToDo)
                   .filter(ToDo.todoid == TodoId)
                   .first())
    toComplete.completed = not toComplete.completed
    db.commit()