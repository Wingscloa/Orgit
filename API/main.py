from fastapi import FastAPI, HTTPException
from db.session import SessionLocal 
from schemas.users import UserResponse
from schemas.users import UserCreate
from db.models.users import User
from db.models.EmailExists import EmailExists



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

@app.get('/Users')
async def Users():
    db = SessionLocal()

    try:
        response = db.query(User).all()
        db.flush()
        db.close()
        return HTTPException(status_code=200,detail=response)
    except:
        return HTTPException(status_code=500,detail="Internal Server Error")

@app.post('/User')
async def addUser(userModel : UserCreate):
    db = SessionLocal()

    try:
        newUser = User(**userModel.model_dump())
        db.add(newUser)
        db.flush()
        db.commit()
        db.close()
        return HTTPException(status_code=201, detail="Successfully created")

    except NameError:
        db.close()
        return HTTPException(status_code=400, detail="Parameters are not correct")     

@app.get('/userById/{userid}')
async def userById(userid: int):
    db = SessionLocal()
    result = db.get(User,userid)
    db.flush()
    db.close()
        
    if not result:
        raise HTTPException(status_code=404, detail="User not found")

    return HTTPException(status_code=200, detail=UserResponse.model_validate(result))


# Check Email

@app.get('/EmailExists/{email}')
async def EmailExist(email: str):
    db = SessionLocal()

    result = db.query(EmailExists).filter(EmailExists.email == email).first()
    db.flush()
    db.close()

    if not result:
        return HTTPException(status_code=404, detail="Email not found")
    
    return HTTPException(status_code=200, detail=True)


# TODO : Resit views pro specificky tasks