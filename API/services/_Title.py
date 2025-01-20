from fastapi import HTTPException
from sqlalchemy.orm import Session
from ..schemas.title import *
from ..db.models.titles import Title
from sqlalchemy import text
from ..db.models.grouptitles import GroupTitles
from ..db.models.userTitles import UserTitle
from ..services._exists import *

async def DBtitleCreate(titleModel: createTitle, db: Session):
    _title = Title(
        **titleModel.model_dump()
    )
    
    db.add(_title)
    db.flush()
    db.commit()
    db.refresh(_title)

async def DBgetTitleByGroupId(groupid: int, db : Session):
    result = (db.query(GroupTitles)
              .filter(GroupTitles.groupid == groupid)
              .all())
    
    if not result:
        raise HTTPException(status_code=404,detail='Group not found')

    db.flush()
    return result


async def DBdeleteTitle(titleid: int, db: Session):
    _toDelete = (db.query(Title)
                 .filter(Title.titleid == titleid)
                 .first())

    if not _toDelete:
        db.flush()
        return False

    db.delete(_toDelete)
    db.flush()
    db.commit()

    return True

# in DB => FUNCTION (Func_get_all_titles(group_id INT))
async def DBgetAllTitles(groupid: int, db : Session):
    if not await groupExists(groupid=groupid,db=db):
        raise HTTPException(status_code=404, detail="Group doesn't exists")
    
    sql_query = text("SELECT * FROM Func_get_all_titles(:groupid)")
    # query --> mapping --> dict --> all --> json
    result = db.execute(sql_query,{'groupid':groupid}).mappings().all()
    
    if not result:
        return False
    
    db.flush()

    return result

async def DBtitleToUser(model : titleToUser,db: Session):
    if not await userExists(model.userid,db=db):
        raise HTTPException(status_code=404, detail="User doesn't exists")
    
    if not await titleExists(model.titleid,db=db):
        raise HTTPException(status_code=404, detail="Title doesn't exists")
    
    exist = (db.query(UserTitle).
             filter(
                 (UserTitle.userid == model.userid)&
                 (UserTitle.titleid == model.titleid)
             )).first()
    
    if exist:
        raise HTTPException(status_code=404,detail="Is already in Database")
    
    _usertitle = UserTitle(**model.model_dump())

    db.add(_usertitle)
    db.flush()
    db.commit()
    db.refresh(_usertitle)
    
    return True
