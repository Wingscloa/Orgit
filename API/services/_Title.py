from fastapi import HTTPException
from sqlalchemy.orm import Session
from schemas.title import *
from db.models.titles import Title
from sqlalchemy import text
from db.models.userTitles import UserTitle
from session import getDb
from fastapi import Depends

async def DBtitleCreate(titleModel: createTitle, db : Session = Depends(getDb)):
    _title = Title(
        **titleModel.model_dump()
    )
    
    db.add(_title)
    db.flush()
    db.commit()
    db.refresh(_title)

async def DBdeleteTitle(titleid: int, db : Session = Depends(getDb)):
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