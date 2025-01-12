from sqlalchemy.orm import Session
from db.models.EmailExists import EmailExists
from db.models.AllGroups import AllGroups


async def DBemailExists(email:str, db : Session):
    result = db.query(EmailExists).filter(EmailExists.email == email).first()
    db.flush()
    return result


async def DBallGroupsFromTo(start : int, count : int, db: Session):
    result = (db.query(AllGroups)
              .offset(start)
              .limit(count)
              .all())
    db.flush()
    return result

async def DBnearGroup(city : str,start: int, count : int, db : Session):
    result = (db.query(AllGroups)
              .filter(AllGroups.name == city)
              .offset(start)
              .limit(count)
              .all())
    db.flush()
    return result

async def DBsearchGroupByName(name : str, start: int, count: int, db : Session):
    result = (db.query(AllGroups)
              .filter(AllGroups.name.like(f"%{name}%"))
              .offset(start)
              .limit(count)
              .all())
    db.flush()
    return result
