from ..db.models.users import User 
from sqlalchemy.orm import Session
from ..schemas.users import *
from ..db.models.users import User
from ..db.models.groupMembers import GroupMember
from ..db.models.eventParticipants import EventParticipant
from ..services._exists import *


async def DBcreateUser(userModel: UserCreate, db: Session):
    try:
        newuser = User(
            **userModel.model_dump()
        )
        
        db.add(newuser)
        db.commit()
        db.flush() 
        db.refresh(newuser)
    except Exception as err:
        raise Exception(err)

async def DBgetUsers(db: Session):
    try:   
        result = db.query(User).all()

        if not result:
            raise HTTPException(status_code=404, detail="Users not found")
        return result
    except Exception as err:
        raise Exception(err)

async def DBgetUserByUid(useruid: str, db: Session):
    try:
        result = (db.query(User).
                filter(User.useruid == useruid)
                .first())

        if not result:
            raise HTTPException(status_code=404, detail="User is not found")
        
        return result
    
    except Exception as err:
        raise Exception(err)


async def DBCreateProfileForm(model : CreateProfileForm, db : Session):
    try:
        user = (db.query(User)
                .filter(User.useruid == model.useruid)
                .first())
        
        if not user:
            raise HTTPException(status_code=404, detail="User is not found")

        user.firstname = model.firstname
        user.lastname = model.lastname
        user.nickname = model.nickname
        user.profileicon = model.profileicon
        user.birthday = model.birthday
        user.telephoneprefix = model.telephoneprefix
        user.telephonenumber = model.telephonenumber

        db.commit()
        db.flush()
        db.refresh(user)
    except Exception as err:
        raise Exception(err)


async def DBdeleteUser(model : DeleteUser, db : Session):
    try:
        user = (db.query(User)
                .filter(User.userid == model.userid)
                .first())

        if not user:
            raise HTTPException(status_code=404, detail="User is not found")        

        user.deleted = model.deleted
        user.deletedat = model.deletedat
        user.lastactive = model.deletedat

        db.commit()
        db.refresh(user)
        db.flush()

    except Exception as err:
        raise Exception(err)

async def DBuserToGroup(model: userToGroup, db : Session):
    if not await userExists(model.userid,db=db):
        raise HTTPException(status_code=404, detail="User is not found")

    if not await groupExists(model.groupid,db=db):
        raise HTTPException(status_code=404, detail="Group is not found")
    
    try:    
        _groupMember = GroupMember(**model.model_dump())

        db.add(_groupMember)
        db.commit()
        db.flush()
        db.refresh(_groupMember)
        
    except Exception as err:
        raise Exception(err)

async def DBuserToEvent(model: sch_userToEvent, db: Session):
    # Exceptions
    if not await eventExists(model.eventid,db=db):
        raise HTTPException(status_code=404, detail="Event has not found")
    
    if not await userExists(model.userid,db=db):
        raise HTTPException(status_code=404, detail="User is not found")
    
    try:
        exist = (db.query(EventParticipant).
                filter((EventParticipant.eventid == model.eventid)&
                        (EventParticipant.userid == model.userid)
                        ).first())
        
        if exist:
            raise HTTPException(status_code=409, detail="Request is duplicated")
        
        # CREATE

        _userToEvent = EventParticipant(**model.model_dump())

        db.add(_userToEvent)
        db.commit()
        db.flush()
        db.refresh(_userToEvent)
    except Exception as err:
        raise Exception(err)