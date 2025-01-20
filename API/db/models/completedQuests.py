from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy import Index
from ...db.base import Base

class CompletedQuest(Base):
    __tablename__ = 'completedquests'

    # Columns
    bubblequestsid = Column(Integer, ForeignKey('bubblequests.bubblequestsid', ondelete='CASCADE'), primary_key=True)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), primary_key=True)

    # Relationships
    bubble_quest = relationship('BubbleQuest', backref='completed_quests')
    user = relationship('User', backref='completed_quests')

# Create an index for UserId
Index('idx_completedquests_userid', CompletedQuest.userid)
