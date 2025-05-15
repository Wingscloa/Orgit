from fastapi import APIRouter, HTTPException, Depends
from session import getDb
from fastapi.responses import JSONResponse
from services._User import *
from schemas.users import *
from auth import verify_firebase_token
from typing import List

router = APIRouter()

@router.get('/User', response_model=List[UserResponse])
async def get_user_all(verify = Depends(verify_firebase_token),db : Session = Depends(getDb)):
    try:
        response = get_users(db)
        return response 
    except HTTPException as err:
        raise HTTPException(status_code=500, detail=f"{err}")
    
@router.post('/User/')
async def post_user_register(model : RegisterSchema,  db : Session = Depends(getDb)):
    try:
        user_register(model,db)
        return JSONResponse(status_code=200,content={"message" : "User is registered"})
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"{err}")

@router.put('/User')
async def put_user_profile_form(model : ProfileSchema, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        user_UpdateProfile(model,db)
        return JSONResponse(status_code=201,content={"message" : "User profile is updated"})
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"{err}")

@router.delete('/User')
async def delete_user_by_id(useruid : str, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        response = delete_user(useruid,db)
        if not response:
            return JSONResponse(status_code=404,content={"message" : "User is deleted"})
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"{err}")
    
# @router.get('/UserByUId/{useruid}')
# async def userByUid(useruid: str, db : SessionDep):
#     try:
#         response = await DBgetUserByUid(useruid=useruid,db=db)
#         return HTTPException(status_code=200,detail=f"{response}")
#     except Exception as err:
#         return HTTPException(status_code=500, detail=f"{err}")
#     finally:
#         db.close()


# @router.post('/UserToGroup')
# async def userToGroup(model: userToGroup, db : SessionDep):
#     try:
#         response = await DBuserToGroup(model=model, db=db)
#         return HTTPException(status_code=200, detail="Success")
#     except Exception as err:
#         return HTTPException(status_code=400, detail=f"Contact support - Exception error : {err}")
#     finally:
#         db.close()
    

# @router.post('/UserToEvent')
# async def userToEvent(model: sch_userToEvent, db : SessionDep):    
#     try:
#         response = await DBuserToEvent(model=model,db=db)    
#         if not response:
#             return HTTPException(status_code=404, detail="Not Found")
#         return HTTPException(status_code=200, detail="Success")
#     except Exception as err:
#         return HTTPException(status_code=404, detail=f"{err}")
#     finally:
#         db.close()