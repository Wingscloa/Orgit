from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship
from db.base import Base

class EventItem(Base):
    __tablename__ = 'eventitems'

    # Columns
    eventitemid = Column(Integer, primary_key=True, autoincrement=True)
    eventid = Column(Integer, ForeignKey('events.eventid', ondelete='CASCADE'), nullable=False)
    name = Column(String(255), nullable=False)
    quantity = Column(Integer, nullable=False, default=1)
    createdat = Column(TIMESTAMP, default='CURRENT_TIMESTAMP')

    # Relationships
    event = relationship('Event', backref='event_items')
