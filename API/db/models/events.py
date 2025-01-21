from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP, LargeBinary, Boolean, Date
from sqlalchemy.orm import relationship
from ...db.base import Base
from datetime import datetime

class Event(Base):
    __tablename__ = 'events'

    # Columns
    eventid = Column(Integer, primary_key=True, autoincrement=True)
    groupid = Column(Integer, ForeignKey('groups.groupid', ondelete='CASCADE'), nullable=True)
    creator = Column(Integer, ForeignKey('users.useruid', ondelete='CASCADE'), nullable=False)
    groupevent = Column(Boolean, nullable=False)
    name = Column(String(32), nullable=False)
    description = Column(String(512), nullable=False)
    profilepic = Column(LargeBinary, nullable=True)
    address = Column(String(255), nullable=False)
    begins = Column(TIMESTAMP, nullable=False)
    ends = Column(TIMESTAMP, nullable=False)
    createdat = Column(TIMESTAMP, default=datetime.now())
    colour = Column(String(7), nullable=True, default='#FFCB69')
    date = Column(Date, nullable=False)

    # Relationships
    group = relationship('Group', backref='events')
    user = relationship('User', backref='events')