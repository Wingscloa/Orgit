from sqlalchemy.orm import Session
from db.models.reports import Report
from schemas.reports import *
from session import getDb
from fastapi import Depends

async def DBCreateReport(model: CreateReport, db : Session = Depends(getDb)):
    _newReport = Report(**model.model_dump())

    db.add(_newReport)
    db.flush()
    db.commit()
    db.refresh(_newReport)

    return True


async def DBgetReport(userid: int, db : Session = Depends(getDb)):
    _result = (db.query(Report)
               .filter(Report.userid == userid)
               .all())
    db.flush()
    
    if not _result:
        return False
    
    return _result

async def DBdeleteReport(reportid: int, db : Session = Depends(getDb)):
    _toDelete = (db.query(Report)
                 .filter(Report.reportid == reportid)
                 .first())

    if not _toDelete:
        db.flush()
        return False

    db.delete(_toDelete)
    db.flush()
    db.commit()

    return True