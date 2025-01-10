from sqlalchemy import Column, Integer, String, ForeignKey, LargeBinary, DateTime
from sqlalchemy.orm import relationship
from db.base import Base
from datetime import datetime

class BubbleQuest(Base):
    __tablename__ = 'bubblequests'

    # Columns
    bubblequestsid = Column(Integer, primary_key=True, autoincrement=True)
    bubblegroupid = Column(Integer, ForeignKey('bubblegroups.bubblegroupid', ondelete='CASCADE'), nullable=False)
    name = Column(String(64), nullable=False)
    questnote = Column(String(255), nullable=False)
    profilepic = Column(LargeBinary, nullable=False)
    experience = Column(Integer, nullable=True)
    title = Column(Integer, ForeignKey('titles.titleid', ondelete='CASCADE'), nullable=True)
    createdby = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), nullable=False)
    createdat = Column(DateTime, default=datetime.utcnow)

    # Relationships
    bubble_group = relationship('BubbleGroup', backref='bubble_quests')
    titles = relationship('Title', backref='bubble_quests')
    created_by = relationship('User', backref='bubble_quests')
