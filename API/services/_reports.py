from sqlalchemy.orm import Session
from db.models.reports import Report
from schemas.reports import *

async def DBCreateReport(model: CreateReport, db: Session):
    _newReport = Report(**model.model_dump())

    db.add(_newReport)
    db.flush()
    db.commit()
    db.refresh(_newReport)

    return True


async def DBgetReport(userid: int, db: Session):
    _result = (db.query(Report)
               .filter(Report.userid == userid)
               .all())
    db.flush()
    
    if not _result:
        return False
    
    return _result

async def DBdeleteReport(reportid: int, db: Session):
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