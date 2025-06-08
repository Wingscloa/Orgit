from fastapi import APIRouter, HTTPException, Depends
from session import getDb
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

@router.get('/User/id/{useruid}', response_model=int)
async def get_userid_by_uid(useruid: str, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        response = get_userId_by_uid(useruid, db)
        if not response:
            raise HTTPException(status_code=404, detail="User not found")
        return response
    except HTTPException as err:
        raise HTTPException(status_code=500, detail=f"{err}")
    
@router.post('/User/', status_code=200)
async def post_user_register(model : RegisterSchema,  db : Session = Depends(getDb)):
    try:
        user_register(model,db)
        return {"message": "User is registered", "status": "success"}
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"{err}")

@router.get('/User/exists/')
async def check_if_user_exists(useruid: str, db: Session = Depends(getDb)):
    try:
        exists = check_user_exists(useruid, db)
        return exists
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"{err}")

@router.get('/User/profile-complete/')
async def check_if_user_profile_complete(useruid: str, db: Session = Depends(getDb)):
    try:
        profile_complete = check_user_profile_complete(useruid, db)
        return {"profile_complete": profile_complete}
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"{err}")

@router.get('/User/in-group/')
async def check_if_user_in_group(useruid: str, db: Session = Depends(getDb)):
    try:
        in_group = check_user_in_group(useruid, db)
        return {"in_group": in_group}
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"{err}")

@router.put('/User', status_code=200)
async def put_user_profile_form(model : ProfileSchema, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        print(f"DEBUG: Received model type: {type(model)}")
        print(f"DEBUG: Received model data: {model}")
        print(f"DEBUG: Model dict: {model.model_dump() if model else 'None'}")
        
        user_UpdateProfile(model,db)
        return {"message": "User profile is updated", "status": "success"}
    except Exception as err:
        print(f"DEBUG: Error in endpoint: {err}")
        raise HTTPException(status_code=500, detail=f"{err}")

@router.delete('/User', status_code=200)
async def delete_user_by_id(useruid : str, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        response = delete_user(useruid,db)
        if not response:
            return {"message": "User is deleted", "status": "success"}
        return {"message": "User not found", "status": "error"}
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