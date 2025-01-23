from sqlalchemy.orm import Session
from ..db.models.EmailExists import EmailExists
from ..db.models.AllGroups import AllGroups
from fastapi import HTTPException

async def DBemailExists(email:str, db : Session):
    try:
        result = db.query(EmailExists).filter(EmailExists.email == email).first()
        db.flush()
        
        if not result:
            raise HTTPException(status_code=404, detail="Email doesn't exists")
        return result
    except Exception as err:
        raise Exception(err)


async def DBallGroupsFromTo(start : int, count : int, db: Session):
    try:
        result = (db.query(AllGroups)
                .offset(start)
                .limit(count)
                .all())
        
        if not result:
            raise HTTPException(status_code=404, detail="Groups has not found")
        db.flush()
        return result
    except Exception as err:
        raise Exception(err)

async def DBnearGroup(city : str,start: int, count : int, db : Session):
    try:
        result = (db.query(AllGroups)
                .filter(AllGroups.name == city)
                .offset(start)
                .limit(count)
                .all())
        # result can be null, it's searching so if it's null ==> city doesn't have groups
        db.flush()
        return result
    except Exception as err:
        raise Exception(err)

async def DBsearchGroupByName(name : str, start: int, count: int, db : Session):
    try:
        result = (db.query(AllGroups)
                .filter(AllGroups.name.like(f"%{name}%"))
                .offset(start)
                .limit(count)
                .all())
        db.flush()
        # result can be null, cuz of searching
        return result
    except Exception as err:
        raise Exception(err)