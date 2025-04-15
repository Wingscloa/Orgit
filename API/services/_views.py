from sqlalchemy.orm import Session
from db.models.View.AllGroups import AllGroups
from fastapi import HTTPException

# result can be null, it's searching

def group_search(start : int, count : int, db: Session):
    try:
        result = (db.query(AllGroups)
                    .offset(start)
                    .limit(count)
                    .all())
        return result
    except Exception as err:
        raise err

def group_search_city(city : str,start: int, count : int, db : Session):
    try:
        result = (db.query(AllGroups)
                .filter(AllGroups.name == city)
                .offset(start)
                .limit(count)
                .all())
        return result
    except Exception as err:
        raise err

def group_search_name(name : str, start: int, count: int, db : Session):
    try:
        result = (db.query(AllGroups)
                .filter(AllGroups.name.like(f"%{name}%"))
                .offset(start)
                .limit(count)
                .all())
        return result
    except Exception as err:
        raise HTTPException(status_code=400, detail=f"Contact support\nException error : {err}")