from fastapi import HTTPException
from db.models.users import User 
from sqlalchemy.orm import Session
from schemas.users import *
from db.models.users import User
from db.models.groupMembers import GroupMember
from db.models.eventParticipants import EventParticipant

def user_register(userModel: RegisterSchema, db: Session):
    try:
        user = User()
        user.email = userModel.email
        user.useruid = userModel.useruid
        db.add(user)
        db.commit()
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"{err}")

def user_UpdateProfile(userModel: ProfileSchema, db: Session):
    try:
        user = db.query(User).filter(User.useruid == userModel.useruid).first()
        user.firstname = userModel.firstname
        user.lastname = userModel.lastname
        user.nickname = userModel.nickname
        user.telephoneprefix = userModel.telephoneprefix
        user.telephonenumber = userModel.telephonenumber
        user.birthday = userModel.birthday
        user.profileicon = userModel.profileicon
        db.commit()
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"{err}")
    

def get_users(db: Session):
    try:   
        result = db.query(User).all()
        if not result:
            raise HTTPException(status_code=404, detail="Users not found")
        return result
    except Exception as err:
        raise HTTPException(status_code=500, detail=str(err))

def delete_user(useruid : str, db : Session):
    try:
        user = (db.query(User)
                .filter(User.useruid == useruid)
                .first())
        if not user:
            raise Exception(status_code=404, detail="User is not found")        
        user.deleted = True
        user.deletedat = datetime.now()
        user.lastactive = user.deletedat
        db.commit()
    except Exception as err:
        raise Exception(err)

# async def DBgetUserByUid(useruid: str, db: Session):
#     try:
#         result = (db.query(User).
#                 filter(User.useruid == useruid)
#                 .first())

#         if not result:
#             raise HTTPException(status_code=404, detail="User is not found")
        
#         return result
    
#     except Exception as err:
#         raise Exception(err)



# async def DBuserToGroup(model: UserGroup, db : Session):
#     # if not await userExists(model.userid,db=db):
#     #     raise HTTPException(status_code=404, detail="User is not found")

#     # if not await groupExists(model.groupid,db=db):
#     #     raise HTTPException(status_code=404, detail="Group is not found")
    
#     try:    
#         _groupMember = GroupMember(**model.model_dump())

#         db.add(_groupMember)
#         db.commit()
#         db.flush()
#         db.refresh(_groupMember)
        
#     except Exception as err:
#         raise Exception(err)

# async def DBuserToEvent(model: UserEvent, db: Session):
#     # Exceptions
#     # if not await eventExists(model.eventid,db=db):
#     #     raise HTTPException(status_code=404, detail="Event has not found")
    
#     # if not await userExists(model.userid,db=db):
#     #     raise HTTPException(status_code=404, detail="User is not found")
    
#     try:
#         exist = (db.query(EventParticipant).
#                 filter((EventParticipant.eventid == model.eventid)&
#                         (EventParticipant.userid == model.userid)
#                         ).first())
        
#         if exist:
#             raise HTTPException(status_code=409, detail="Request is duplicated")
        
#         # CREATE

#         _userToEvent = EventParticipant(**model.model_dump())

#         db.add(_userToEvent)
#         db.commit()
#         db.flush()
#         db.refresh(_userToEvent)
#     except Exception as err:
#         raise Exception(err)