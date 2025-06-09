from sqlalchemy.orm import Session
from db.models.regions import Regions
from session import getDb 
from fastapi import Depends, HTTPException

def region_all(db: Session = Depends(getDb)):
    """Vrátí všechny regiony"""
    regions = db.query(Regions).all()
    
    result = []
    for region in regions:
        result.append({
            'regionid': region.regionid,
            'name': region.name
        })
    
    return result

def region_by_id(region_id: int, db: Session = Depends(getDb)):
    """Vrátí region podle ID"""
    region = (db.query(Regions)
              .filter(Regions.regionid == region_id)
              .first())
    
    if not region:
        raise HTTPException(status_code=404, detail="Region not found")
    
    return {
        'regionid': region.regionid,
        'name': region.name
    }

def region_by_name(region_name: str, db: Session = Depends(getDb)):
    """Vrátí region podle názvu"""
    region = (db.query(Regions)
              .filter(Regions.name == region_name)
              .first())
    
    if not region:
        raise HTTPException(status_code=404, detail="Region not found")
    
    return {
        'regionid': region.regionid,
        'name': region.name
    }
