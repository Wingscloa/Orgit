from sqlalchemy.orm import Session, joinedload
from schemas.group import GroupSchema
from db.models.groups import Group
from db.models.groupMembers import GroupMember
from db.models.users import User
from db.models.cities import Cities
from db.models.regions import Regions
from session import getDb 
from fastapi import Depends, HTTPException

def group_all(db : Session = Depends(getDb)):
    groups = (db.query(Group)
              .join(Cities, Group.city == Cities.cityid)
              .join(Regions, Group.region == Regions.regionid)
              .options(joinedload(Group.city_rel), joinedload(Group.region_rel))
              .all())
    
    transformed_groups = []
    for group in groups:
        group_dict = {
            'groupid': group.groupid,
            'profilepicture': group.profilepicture,
            'name': group.name,            'cityid': group.city,
            'regionid': group.region,
            'city_name': group.city_rel.name if group.city_rel else '',
            'region_name': group.region_rel.name if group.region_rel else '',
            'leader': group.leader,
            'description': group.description,
            'createdby': group.createdby,
            'createdat': group.createdat,
            'deleted': group.deleted
        }
        transformed_groups.append(group_dict)
    
    return transformed_groups

def group_create(groupModel: GroupSchema, db : Session = Depends(getDb)):
    _groupModel = Group(
        **groupModel.model_dump()
    )
    
    db.add(_groupModel)
    db.commit()
    db.refresh(_groupModel)  # Refresh to get the generated ID
    
    return _groupModel.groupid  # Return the new group ID

def group_by_id(groupid: int, db : Session = Depends(getDb)):
    result = (db.query(Group)
             .join(Cities, Group.city == Cities.cityid)
             .join(Regions, Group.region == Regions.regionid)
             .options(joinedload(Group.city_rel), joinedload(Group.region_rel))
             .filter(Group.groupid == groupid)
             .first())
    
    if not result:
        raise ValueError("Group not found")
    
    group_dict = {
        'groupid': result.groupid,
        'profilepicture': result.profilepicture,
        'name': result.name,
        'cityid': result.city,
        'regionid': result.region,
        'city_name': result.city_rel.name if result.city_rel else '',
        'region_name': result.region_rel.name if result.region_rel else '',
        'leader': result.leader,
        'description': result.description,
        'createdby': result.createdby,
        'createdat': result.createdat,
        'deleted': result.deleted
    }
    
    return [group_dict]  # vracím jako list pro kompatibilitu s response_model

def group_delete(groupid: int, db: Session):
    _toDelete = (db.query(Group)
                 .filter(Group.groupid == groupid)
                 .first())

    if not _toDelete:
        raise ValueError("Group not found")

    _toDelete.deleted = True
    db.commit()

def group_add_member(userid: int, groupid: int, db: Session = Depends(getDb)):
    try:
        group = db.query(Group).filter(Group.groupid == groupid).first()
        if not group:
            raise HTTPException(status_code=404, detail="Group not found")
        
        user = db.query(User).filter(User.userid == userid).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        
        existing_membership = db.query(GroupMember).filter(
            GroupMember.groupid == groupid,
            GroupMember.userid == userid
        ).first()
        
        if existing_membership:
            raise HTTPException(status_code=409, detail="User is already a member of this group")
        
        # Add user to group
        new_member = GroupMember(groupid=groupid, userid=userid)
        db.add(new_member)
        db.commit()
        
        return {"message": "User successfully added to group", "status": "success"}
        
    except HTTPException:
        raise
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Error adding user to group: {str(err)}")

def group_remove_member(userid: int, groupid: int, db: Session = Depends(getDb)):
    try:
        group = db.query(Group).filter(Group.groupid == groupid).first()
        if not group:
            raise HTTPException(status_code=404, detail="Group not found")
        
        user = db.query(User).filter(User.userid == userid).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        
        membership = db.query(GroupMember).filter(
            GroupMember.groupid == groupid,
            GroupMember.userid == userid
        ).first()
        
        if not membership:
            raise HTTPException(status_code=404, detail="User is not a member of this group")
        
        if group.leader == userid:
            raise HTTPException(status_code=403, detail="Cannot remove group leader from group")
        
        db.delete(membership)
        db.commit()
        
        return {"message": "User successfully removed from group", "status": "success"}
        
    except HTTPException:
        raise
    except Exception as err:
        raise HTTPException(status_code=500, detail=f"Error removing user from group: {str(err)}")