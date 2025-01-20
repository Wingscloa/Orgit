from sqlalchemy import Column, Integer, ForeignKey, String, TIMESTAMP
from sqlalchemy.orm import relationship
from ...db.base import Base

class Reaction(Base):
    __tablename__ = 'reactions'

    # Columns
    reactionid = Column(Integer, primary_key=True, autoincrement=True)
    messageid = Column(Integer, ForeignKey('messages.messageid', ondelete='CASCADE'), nullable=False)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), nullable=False)
    emoji = Column(String(32), nullable=False)
    reactedat = Column(TIMESTAMP, default='CURRENT_TIMESTAMP')

    # Relationships
    message = relationship('Message', backref='reactions')
    user = relationship('User', backref='reactions')
