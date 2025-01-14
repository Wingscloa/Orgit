from db.models.users import User 
from sqlalchemy.orm import Session
from schemas.users import *
from db.models.users import User
from db.models.groupMembers import GroupMember
from db.models.eventParticipants import EventParticipant
from services._exists import *


async def DBcreateUser(userModel: UserCreate, db: Session):
    newuser = User(
        **userModel.model_dump()
    )
    
    db.add(newuser)
    db.flush() 
    db.commit()
    db.refresh(newuser)


async def DBgetUsers(db: Session):
    response = db.query(User).all()
    db.flush()
    return response

async def DBgetUserById(userid: int, db: Session):
    result = (db.query(User).
              filter(User.userid == userid)
              .first())
    db.flush()
    return result


async def DBupdateUserForm(model : UpdateUserForm, db : Session):
    user = (db.query(User)
            .filter(User.userid == model.userid)
            .first())
    
    if not user:
        return False
    
    user.firstname = model.firstname
    user.lastname = model.lastname
    user.nickname = model.nickname
    user.birthday = model.birthday
    user.telephonenumber = model.telephonenumber

    db.commit()
    db.refresh(user)
    db.flush()
    return True


async def DBdeleteUser(model : DeleteUser, db : Session):
    user = (db.query(User)
            .filter(User.userid == model.userid)
            .first())
    
    if not user:
        return False
    
    user.deleted = model.deleted
    user.deletedat = model.deletedat
    user.lastactive = model.deletedat

    db.commit()
    db.refresh(user)
    db.flush()
    return True


async def DBuserToGroup(model: userToGroup, db : Session):
    if not await userExists(model.userid,db=db):
        return False

    if not await groupExists(model.groupid,db=db):
        return False
    
    _groupMember = GroupMember(**model.model_dump())

    db.add(_groupMember)
    db.flush()
    db.commit()
    db.refresh(_groupMember)


async def DBuserToEvent(model: sch_userToEvent, db: Session):
    # Exceptions
    if not await eventExists(model.eventid,db=db):
        raise Exception("Event doesn't exists")
    
    if not await userExists(model.userid,db=db):
        raise Exception("User doesn't exists")
    
    exist = (db.query(EventParticipant).
             filter((EventParticipant.eventid == model.eventid)&
                    (EventParticipant.userid == model.userid)
                    ).first())
    
    if exist:
        raise Exception("Already exists")
    
    # CREATE

    _userToEvent = EventParticipant(**model.model_dump())

    db.add(_userToEvent)
    db.flush()
    db.commit()
    db.refresh(_userToEvent)