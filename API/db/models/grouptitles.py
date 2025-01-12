from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship, backref
from db.base import Base

class GroupTitles(Base):
    __tablename__ = 'grouptitles'

    # Columns
    titleid = Column(Integer, ForeignKey('titles.titleid', ondelete='CASCADE'), primary_key=True)
    groupid = Column(Integer, ForeignKey('groups.groupid', ondelete='CASCADE'), primary_key=True)

    # Rels
    _title = relationship('Title',backref=backref("children", cascade="all,delete"))
    _group = relationship('Group',backref=backref("children", cascade="all,delete"))
