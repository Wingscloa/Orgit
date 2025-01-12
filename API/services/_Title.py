from sqlalchemy.orm import Session
from schemas.title import createTitle
from db.models.titles import Title
from sqlalchemy import text
from db.models.grouptitles import GroupTitles


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
        return False

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

    sql_query = text("SELECT * FROM Func_get_all_titles(:groupid)")
    # query --> mapping --> dict --> all --> json
    result = db.execute(sql_query,{'groupid':groupid}).mappings().all()
    
    if not result:
        return False
    
    db.flush()

    return result

