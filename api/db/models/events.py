from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship
from base import Base
from datetime import datetime

class Event(Base):
    __tablename__ = 'events'

    # Columns
    eventid = Column(Integer, primary_key=True, autoincrement=True)
    groupid = Column(Integer, ForeignKey('groups.groupid', ondelete='CASCADE'), nullable=True)
    creator = Column(Integer, ForeignKey('users.useruid', ondelete='CASCADE'), nullable=False)
    name = Column(String(32), nullable=False)
    color = Column(String(7), nullable=True, default='#FFCB69')
    description = Column(String(512), nullable=False)
    address = Column(String(255), nullable=False)
    begins = Column(TIMESTAMP, nullable=False)
    ends = Column(TIMESTAMP, nullable=False)
    createdat = Column(TIMESTAMP, default= datetime.now())
    # iconid = Column(Integer, ForeignKey('icon.iconid', ondelete='CASCADE'), nullable=False)