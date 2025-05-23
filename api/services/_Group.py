from sqlalchemy.orm import Session
from schemas.group import GroupSchema
from db.models.groups import Group
from session import getDb 
from fastapi import Depends

def group_all(db : Session = Depends(getDb)):
    response = db.query(Group).all()
    return response

# Create a new group in the database
def group_create(groupModel: GroupSchema, db : Session = Depends(getDb)):
    _groupModel = Group(
        **groupModel.model_dump()
    )
    
    db.add(_groupModel)
    db.commit()

# Get a group by its ID
def group_by_id(groupid: int, db : Session = Depends(getDb)):
    result = (db.query(Group)
              .filter(Group.groupid == groupid)
              .first())
    
    if not result:
        raise ValueError("Group not found")
    
    return result

def group_delete(groupid: int, db: Session):
    _toDelete = (db.query(Group)
                 .filter(Group.groupid == groupid)
                 .first())

    if not _toDelete:
        raise ValueError("Group not found")

    _toDelete.deleted = True
    db.commit()