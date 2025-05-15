from fastapi import APIRouter, HTTPException, Depends
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse
from session import getDb, SessionLocal
from services._Group import *
from schemas.group import *
from services._views import group_search, group_search_name, group_search_city
from auth import verify_firebase_token
from typing import List

router = APIRouter()

@router.get('/Group', response_model=List[GroupResponse])
async def get_group_all(verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        response = group_all(db)
        return response
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Contact support\nException error : {err}")
    
@router.post('/Group')
async def create_group(groupModel : GroupSchema, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        group_create(groupModel,db=db)
        return True
    except Exception as err:
        raise HTTPException(status_code=400, detail="Parameters are not correct")
    
@router.delete('/Group')
async def delete_group_by_id(groupid: int, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        group_delete(groupid,db)
        return JSONResponse(status_code=200, content={"message": "Group deleted"})
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Contact support - Exception error : {err}")

@router.get('/Group/{groupid}',  response_model=List[GroupResponse])
async def get_group_by_id(groupid:int, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    try:
        result = group_by_id(groupid=groupid,db=db)
        return result
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Contact support\nException error : {err}")

@router.get('/Groups/{start}/{count}', response_model=list[GroupSearchResponse])
async def get_groups_paginated(start :int, count: int, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    if(start < 0):
        raise HTTPException(status_code=400, detail="Start can't be negative")
    elif count <= 0:
        raise HTTPException(status_code=400, detail="Count can't be less or equal to zero")

    try:
        result = group_search(start,count,db)
        return result
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Error contact support: {err}")

@router.get('/Group/{city}', response_model=list[GroupSearchResponse])
async def get_group_by_city(city : str, start: int, count : int, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    if(start < 0):
        raise HTTPException(status_code=400, detail="Start can't be negative")
    elif count <= 0:
        raise HTTPException(status_code=400, detail="Count can't be less or equal to zero")

    try:
        result = group_search_city(city, start, count, db)
        return result
    except Exception as err:
        raise HTTPException(status_code=500, detail="Contact Support\nException error : {err}")

@router.get('/Group/{name}', response_model=list[GroupSearchResponse])
async def get_group_by_name(name: str, start: int, count: int, verify = Depends(verify_firebase_token), db : Session = Depends(getDb)):
    if(start < 0):
        raise HTTPException(status_code=400, detail="Start can't be negative")
    elif count <= 0:
        raise HTTPException(status_code=400, detail="Count can't be less or equal to zero")
    try:
        result = group_search_name(name,start,count,db)
        return result
    except Exception as err:
        raise HTTPException(status_code=400, detail="Contact Support\nException error : {err}")