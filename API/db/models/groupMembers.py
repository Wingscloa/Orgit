from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from db.base import Base

class GroupMember(Base):
    __tablename__ = 'groupmembers'

    # Columns
    groupid = Column(Integer, ForeignKey('groups.groupid', ondelete='CASCADE'), primary_key=True)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), primary_key=True)

    # Relationships
    group = relationship('Group', backref='members')
    user = relationship('User', backref='groups')
