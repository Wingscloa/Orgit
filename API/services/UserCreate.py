from db.models.users import User 
from sqlalchemy.orm import Session
from schemas.users import UserCreate
from sqlalchemy.future import select
from db.session import SessionLocal 
import asyncio
from datetime import datetime


async def createuser(userdata: UserCreate, db: Session):
    newuser = User(
        useruid=userdata.useruid,
        firstname=userdata.firstname,
        lastname=userdata.lastname,
        nickname=userdata.nickname,
        email=userdata.email,
        profileicon=userdata.profileicon,
        telephoneprefix=userdata.telephoneprefix,
        telephonenumber=userdata.telephonenumber,
    )
    
    db.add(newuser)
    db.commit()
    db.refresh(newuser)
    return newuser


# newuserdata = {
#     'useruid': '12312',
#     'firstname': 'Filipek',
#     'lastname': 'Ederek',
#     'nickname': 'Testicek',
#     'email': 'dawdaw@example.com',
#     'profileicon': b'100101',
#     'telephoneprefix': '123',
#     'telephonenumber': '704167980'
# }

# usercreate = UserCreate(**newuserdata)

# db = SessionLocal()

# async def udelej():
#     createduser = await createuser(usercreate, db)
#     print(createduser)

# asyncio.run(udelej())