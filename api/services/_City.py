from sqlalchemy.orm import Session, joinedload
from db.models.cities import Cities
from db.models.regions import Regions
from session import getDb 
from fastapi import Depends, HTTPException

def city_all(db: Session = Depends(getDb)):
    cities = (db.query(Cities)
              .join(Regions, Cities.regionid == Regions.regionid)
              .options(joinedload(Cities.region))
              .all())
    
    result = []
    for city in cities:
        result.append({
            'cityid': city.cityid,
            'name': city.name,
            'regionid': city.regionid,
            'region_name': city.region.name if city.region else ''
        })
    
    return result

def city_by_id(city_id: int, db: Session = Depends(getDb)):
    city = (db.query(Cities)
            .join(Regions, Cities.regionid == Regions.regionid)
            .options(joinedload(Cities.region))
            .filter(Cities.cityid == city_id)
            .first())
    
    if not city:
        raise HTTPException(status_code=404, detail="City not found")
    
    return {
        'cityid': city.cityid,
        'name': city.name,
        'regionid': city.regionid,
        'region_name': city.region.name if city.region else ''
    }

def city_by_name(city_name: str, db: Session = Depends(getDb)):
    city = (db.query(Cities)
            .join(Regions, Cities.regionid == Regions.regionid)
            .options(joinedload(Cities.region))
            .filter(Cities.name == city_name)
            .first())
    
    if not city:
        raise HTTPException(status_code=404, detail="City not found")
    
    return {
        'cityid': city.cityid,
        'name': city.name,
        'regionid': city.regionid,
        'region_name': city.region.name if city.region else ''
    }

def cities_by_region(region_id: int, db: Session = Depends(getDb)):
    cities = (db.query(Cities)
              .join(Regions, Cities.regionid == Regions.regionid)
              .options(joinedload(Cities.region))
              .filter(Cities.regionid == region_id)
              .all())
    
    result = []
    for city in cities:
        result.append({
            'cityid': city.cityid,
            'name': city.name,
            'regionid': city.regionid,
            'region_name': city.region.name if city.region else ''
        })
    
    return result
