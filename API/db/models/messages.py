from sqlalchemy import Column, Integer, ForeignKey, Text, TIMESTAMP
from sqlalchemy.orm import relationship
from sqlalchemy.schema import Index
from ...db.base import Base

class Message(Base):
    __tablename__ = 'messages'

    # Columns
    messageid = Column(Integer, primary_key=True, autoincrement=True)
    chatid = Column(Integer, ForeignKey('chat.chatid', ondelete='CASCADE'), nullable=False)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), nullable=False)
    content = Column(Text, nullable=False)
    sendat = Column(TIMESTAMP, default='CURRENT_TIMESTAMP')

    # Relationships
    chat = relationship('Chat', backref='messages')
    user = relationship('User', backref='messages_sent')

# Index
Index('idx_messages_userid', Message.userid)
