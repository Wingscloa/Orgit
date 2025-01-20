from ..schemas.todo import *
from ..db.models.users import User
from ..db.models.toDo import ToDo
from sqlalchemy.orm import Session

async def DBcreateToDo(model : ToDoCreate, db : Session):
    newTodo = ToDo(**model.model_dump())

    db.add(newTodo)
    db.flush()
    db.commit()
    db.refresh(newTodo)
    return True

async def DBUpdateTodo(model : ToDoUpdate, db : Session):
    _current = (db.query(ToDo)
                .filter(ToDo.todoid == model.todoid)
                .first())
    
    if not _current:
        db.flush()
        return False
    
    _current.thing = model.thing
    _current.note = model.note
    _current.tocomplete = model.tocomplete

    db.flush()
    db.commit()
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
