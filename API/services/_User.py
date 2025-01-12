from db.models.users import User 
from sqlalchemy.orm import Session
from schemas.users import *
from db.models.users import User


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
    
    print("cerny to je ")
    print(model.dict())

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

