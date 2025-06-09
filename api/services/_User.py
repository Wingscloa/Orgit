from fastapi import HTTPException, Depends
from session import getDb
from db.models.users import User 
from sqlalchemy.orm import Session
from schemas.users import *
from db.models.users import User
from datetime import datetime

def user_register(userModel: RegisterSchema, db : Session = Depends(getDb)):
    try:
        user = User(**userModel.model_dump())
        db.add(user)
        db.commit()
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"{err}")

def user_UpdateProfile(userModel: ProfileSchema, db : Session = Depends(getDb)):
    try:
        print(f"DEBUG: userModel type: {type(userModel)}")
        print(f"DEBUG: userModel data: {userModel}")
        
        if userModel is None:
            raise HTTPException(status_code=400, detail="userModel is None")
            
        user = db.query(User).filter(User.useruid == userModel.useruid).first()
        print(f"DEBUG: Found user: {user}")
        
        if user is None:
            # User doesn't exist, create a new one with profile data
            print(f"DEBUG: Creating new user with useruid: {userModel.useruid}")
            user = User(
                useruid=userModel.useruid,
                firstname=userModel.firstname,
                lastname=userModel.lastname,
                nickname=userModel.nickname,
                telephoneprefix=userModel.telephoneprefix,
                telephonenumber=userModel.telephonenumber,
                birthday=userModel.birthday,
                profileicon=userModel.profileicon,
                email="",  # Email will be filled from Firebase token if needed
                verified=False,
                deleted=False,
                level=1,
                experience=0
            )
            db.add(user)
        else:
            # User exists, update their profile
            print(f"DEBUG: Updating existing user: {user.useruid}")
            user.firstname = userModel.firstname
            user.lastname = userModel.lastname
            user.nickname = userModel.nickname
            user.telephoneprefix = userModel.telephoneprefix
            user.telephonenumber = userModel.telephonenumber
            user.birthday = userModel.birthday
            user.profileicon = userModel.profileicon
        
        db.commit()
        print(f"DEBUG: Successfully committed changes")
    except HTTPException as http_err:
        raise http_err
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"{err}")

def get_userId_by_uid(useruid: str, db : Session = Depends(getDb)):
    try:
        user = db.query(User).filter(User.useruid == useruid).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        return user.userid
    except Exception as err:
        raise HTTPException(status_code=500, detail=str(err))

def get_users(db : Session = Depends(getDb)):
    try:   
        result = db.query(User).all()
        if not result:
            raise HTTPException(status_code=404, detail="Users not found")
        return result
    except Exception as err:
        raise HTTPException(status_code=500, detail=str(err))

def check_user_exists(useruid: str, db: Session = Depends(getDb)):
    try:
        user = db.query(User).filter(User.useruid == useruid).first()
        return user is not None
    except Exception as err:
        raise HTTPException(status_code=500, detail=str(err))

def check_user_profile_complete(useruid: str, db: Session = Depends(getDb)):
    try:
        user = db.query(User).filter(User.useruid == useruid).first()
        if not user:
            return False
        
        # Check if all required profile fields are filled
        profile_complete = (
            user.firstname is not None and user.firstname.strip() != "" and
            user.lastname is not None and user.lastname.strip() != "" and
            user.nickname is not None and user.nickname.strip() != "" and
            user.telephoneprefix is not None and user.telephoneprefix.strip() != "" and
            user.telephonenumber is not None and user.telephonenumber.strip() != "" and
            user.birthday is not None
        )
        
        return profile_complete
    except Exception as err:
        raise HTTPException(status_code=500, detail=str(err))

def check_user_in_group(useruid: str, db: Session = Depends(getDb)):
    try:
        from db.models.groupMembers import GroupMember
        
        user = db.query(User).filter(User.useruid == useruid).first()
        if not user:
            return False
        
        # Check if user is member of any group
        group_membership = db.query(GroupMember).filter(GroupMember.userid == user.userid).first()
        
        return group_membership is not None
    except Exception as err:
        raise HTTPException(status_code=500, detail=str(err))

def delete_user(useruid : str, db : Session = Depends(getDb)):
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

def get_user_by_uid(useruid: str, db : Session = Depends(getDb)):
    try:
        result = (db.query(User).
                filter(User.useruid == useruid)
                .first())

        if not result:
            raise HTTPException(status_code=404, detail="User is not found")
        
        return result
    
    except Exception as err:
        raise HTTPException(status_code=500, detail=str(err))



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

# async def DBuserToEvent(model: UserEvent, db : Session = Depends(getDb)):
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