from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from session import getDb
from services._City import *
from services._Region import *
from schemas.location import *
from auth import verify_firebase_token
from typing import List

router = APIRouter()

# Region endpoints
@router.get('/Regions', response_model=List[RegionResponse])
async def get_all_regions(verify = Depends(verify_firebase_token), db: Session = Depends(getDb)):
    try:
        response = region_all(db)
        return response
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Contact support\nException error : {err}")

@router.get('/Region/{region_id}', response_model=RegionResponse)
async def get_region_by_id(region_id: int, verify = Depends(verify_firebase_token), db: Session = Depends(getDb)):
    try:
        result = region_by_id(region_id, db)
        return result
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Contact support\nException error : {err}")

@router.get('/Region/name/{region_name}', response_model=RegionResponse)
async def get_region_by_name(region_name: str, verify = Depends(verify_firebase_token), db: Session = Depends(getDb)):
    try:
        result = region_by_name(region_name, db)
        return result
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Contact support\nException error : {err}")

# City endpoints
@router.get('/Cities', response_model=List[CityResponse])
async def get_all_cities(verify = Depends(verify_firebase_token), db: Session = Depends(getDb)):
    try:
        response = city_all(db)
        return response
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Contact support\nException error : {err}")

@router.get('/City/{city_id}', response_model=CityResponse)
async def get_city_by_id(city_id: int, verify = Depends(verify_firebase_token), db: Session = Depends(getDb)):
    try:
        result = city_by_id(city_id, db)
        return result
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Contact support\nException error : {err}")

@router.get('/City/name/{city_name}', response_model=CityResponse)
async def get_city_by_name(city_name: str, verify = Depends(verify_firebase_token), db: Session = Depends(getDb)):
    try:
        result = city_by_name(city_name, db)
        return result
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Contact support\nException error : {err}")

@router.get('/Cities/region/{region_id}', response_model=List[CityResponse])
async def get_cities_by_region(region_id: int, verify = Depends(verify_firebase_token), db: Session = Depends(getDb)):
    try:
        result = cities_by_region(region_id, db)
        return result
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Contact support\nException error : {err}")
