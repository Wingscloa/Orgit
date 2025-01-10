from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.schema import Index
from db.base import Base

class ChatParticipant(Base):
    __tablename__ = 'chatparticipants'

    # Columns
    chatid = Column(Integer, ForeignKey('chat.chatid', ondelete='CASCADE'), primary_key=True)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), primary_key=True)

    # Relationships
    chat = relationship('Chat', backref='participants')
    user = relationship('User', backref='chats_participated')

# Index
Index('idx_chatparticipants_userid', ChatParticipant.userid)
