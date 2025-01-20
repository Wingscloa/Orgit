from sqlalchemy.orm import Session
from ..schemas.group import GroupCreate
from ..db.models.groups import Group


async def DBcreateGroup(groupModel: GroupCreate, db: Session):
    _groupModel = Group(
        **groupModel.model_dump()
    )
    
    db.add(_groupModel)
    db.flush()
    db.commit()
    db.refresh(_groupModel)

async def DBgetGroupById(groupid: int, db : Session):
    result = (db.query(Group)
              .filter(Group.groupid == groupid)
              .first())
    db.flush()
    return result

async def DBdeleteGroup(groupid: int, db: Session):
    _toDelete = (db.query(Group)
                 .filter(Group.groupid == groupid)
                 .first())

    if not _toDelete:
        db.flush()
        return False

    db.delete(_toDelete)
    db.flush()
    db.commit()

    return True