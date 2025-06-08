from sqlalchemy.orm import Session, joinedload
from db.models.views.AllGroups import AllGroups
from db.models.groups import Group
from db.models.cities import Cities
from db.models.regions import Regions
from fastapi import HTTPException, Depends
from db.models.users import User
from session import getDb


def group_search(start : int, count : int, db : Session = Depends(getDb)):
    try:
        # Používám join místo view pro získání názvů měst a regionů
        result = (db.query(Group)
                    .join(Cities, Group.cityid == Cities.cityid)
                    .join(Regions, Group.regionid == Regions.regionid)
                    .options(joinedload(Group.city), joinedload(Group.region))
                    .offset(start)
                    .limit(count)
                    .all())
        
        # Transformuji výsledek pro GroupSearchResponse
        transformed_result = []
        for group in result:
            transformed_result.append({
                'groupid': group.groupid,
                'name': group.name,
                'profilepicture': group.profilepicture,
                'city_name': group.city.name if group.city else ''
            })
        
        return transformed_result
    except Exception as err:
        raise err

def group_search_city(city : str, start: int, count : int, db : Session = Depends(getDb)):
    try:        # Hledám podle názvu města
        result = (db.query(Group)
                .join(Cities, Group.cityid == Cities.cityid)
                .join(Regions, Group.regionid == Regions.regionid)
                .filter(Cities.name == city)
                .options(joinedload(Group.city), joinedload(Group.region))
                .offset(start)
                .limit(count)
                .all())
        
        # Transformuji výsledek
        transformed_result = []
        for group in result:
            transformed_result.append({
                'groupid': group.groupid,
                'name': group.name,
                'profilepicture': group.profilepicture,
                'city_name': group.city.name if group.city else ''
            })
        
        return transformed_result
    except Exception as err:
        raise err

def group_search_name(name : str, start: int, count: int, db : Session = Depends(getDb)):
    try:
        # Hledám podle názvu skupiny
        result = (db.query(Group)
                .join(Cities, Group.cityid == Cities.CityId)
                .join(Regions, Group.regionid == Regions.regionid)
                .filter(Group.name.like(f"%{name}%"))
                .options(joinedload(Group.city), joinedload(Group.region))
                .offset(start)
                .limit(count)
                .all())
        
        # Transformuji výsledek
        transformed_result = []
        for group in result:
            transformed_result.append({
                'groupid': group.groupid,
                'name': group.name,
                'profilepicture': group.profilepicture,
                'city_name': group.city.name if group.city else ''
            })
        
        return transformed_result
    except Exception as err:
        raise HTTPException(status_code=400, detail=f"Contact support\nException error : {err}")
    
def email_exists(email : str, db : Session = Depends(getDb)):
    try:
        result = db.query(User).filter(User.email == email).first()
        if not result:
            return False
        return True
    except Exception as err:
        raise err
