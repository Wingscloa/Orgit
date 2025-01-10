from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP, LargeBinary
from sqlalchemy.orm import relationship
from db.base import Base

class Event(Base):
    __tablename__ = 'events'

    # Columns
    eventid = Column(Integer, primary_key=True, autoincrement=True)
    groupid = Column(Integer, ForeignKey('groups.groupid', ondelete='CASCADE'), nullable=False)
    name = Column(String(32), nullable=False)
    description = Column(String(512), nullable=False)
    profilepic = Column(LargeBinary, nullable=True)
    begin = Column(TIMESTAMP, nullable=False)
    end = Column(TIMESTAMP, nullable=False)
    createdat = Column(TIMESTAMP, default='CURRENT_TIMESTAMP')

    # Relationships
    group = relationship('Group', backref='events')