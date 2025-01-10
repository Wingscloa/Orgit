from fastapi import FastAPI, HTTPException
from db.session import SessionLocal 
from schemas.users import UserResponse
from schemas.users import UserCreate
from db.models.users import User



# data = db.get(User,15)

# print(data.createdat)


# TEST

# db = SessionLocal()

# newuserdata = {
#     'useruid': '12312',
#     'firstname': 'Adam',
#     'lastname': 'Ederek',
#     'nickname': 'Testicek',
#     'email': 'dawscascas@example.com',
#     'profileicon': b'100101',
#     'telephoneprefix': '123',
#     'telephonenumber': '704167980',
#     'lastactive' : '2025-01-09'
# }

# _user = User(**newuserdata)

# db.add(_user)
# db.commit()


# FastAPI

app = FastAPI()

# User

@app.post('/User')
async def addUser(userModel : UserCreate):
    db = SessionLocal()
    try:
        newUser = User(**userModel.model_dump())
        # model_dummp attributes to dict
        db.add(newUser)
        db.commit()
    except NameError:
        db.close()     

@app.get('/userById/{userid}')
async def userById(userid: int):
    db = SessionLocal()
    userData = db.get(User,userid)
    
    if not userData:
        raise HTTPException(status_code=404, detail="User not found")

    return UserResponse.model_validate(userData)

# TODO : Resit views pro specificky tasks