from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship
from ...db.base import Base

class Chat(Base):
    __tablename__ = 'chat'

    # Columns
    chatid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(32), nullable=True)
    owner = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), nullable=True)
    groupchatid = Column(Integer, ForeignKey('groups.groupid', ondelete='CASCADE'), nullable=True)
    createdat = Column(TIMESTAMP, default='CURRENT_TIMESTAMP')

    # Relationships
    owners = relationship('User', backref='owned_chats')
    group_chat = relationship('Group', backref='group_chats')
