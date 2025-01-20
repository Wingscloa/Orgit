from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from ...db.base import Base

class GroupTree(Base):
    __tablename__ = 'grouptree'

    # Columns
    treeid = Column(Integer, primary_key=True, autoincrement=True)
    groupid = Column(Integer, ForeignKey('groups.groupid', ondelete='CASCADE'), nullable=False)

    # Relationships
    group = relationship('Group', backref='group_tree')
