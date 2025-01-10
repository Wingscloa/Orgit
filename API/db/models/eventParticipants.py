from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.schema import Index
from db.base import Base

class EventParticipant(Base):
    __tablename__ = 'eventparticipants'

    # Columns
    eventid = Column(Integer, ForeignKey('events.eventid', ondelete='CASCADE'), primary_key=True)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), primary_key=True)

    # Relationships
    event = relationship('Event', backref='participants')
    user = relationship('User', backref='events_participated')

# Index
Index('idx_eventparticipants_userid', EventParticipant.userid)
