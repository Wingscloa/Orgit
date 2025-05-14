from sqlalchemy.orm import Session
from db.models.views.AllGroups import AllGroups
from fastapi import HTTPException, Depends
from db.models.users import User
from session import getDb


def group_search(start : int, count : int, db : Session = Depends(getDb)):
    try:
        result = (db.query(AllGroups)
                    .offset(start)
                    .limit(count)
                    .all())
        return result
    except Exception as err:
        raise err

def group_search_city(city : str,start: int, count : int, db : Session = Depends(getDb)):
    try:
        result = (db.query(AllGroups)
                .filter(AllGroups.name == city)
                .offset(start)
                .limit(count)
                .all())
        return result
    except Exception as err:
        raise err

def group_search_name(name : str, start: int, count: int, db : Session = Depends(getDb)):
    try:
        result = (db.query(AllGroups)
                .filter(AllGroups.name.like(f"%{name}%"))
                .offset(start)
                .limit(count)
                .all())
        return result
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
