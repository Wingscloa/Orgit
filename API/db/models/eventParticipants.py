from sqlalchemy import Column, Integer, ForeignKey, Enum
from sqlalchemy.orm import relationship
from sqlalchemy.schema import Index
from db.base import Base
from enum import Enum as PyEnum

class EventPartStatus(PyEnum):
    VP = "Včasný příchod"
    PP = "Pozdní příchod"
    OM = "Omluven"
    NOM = "Neomluven"

class EventParticipant(Base):
    __tablename__ = 'eventparticipants'
    # Columns
    eventid = Column(Integer, ForeignKey('events.eventid', ondelete='CASCADE'), primary_key=True)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), primary_key=True)
    state = Column(Enum(EventPartStatus), nullable=True)

    # Relationships
    event = relationship('Event', backref='participants')
    user = relationship('User', backref='events_participated')

# Index
Index('idx_eventparticipants_userid', EventParticipant.userid)
