from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from db.base import Base
from datetime import datetime


class ToDo(Base):
    __tablename__ = 'todo'

    # Columns
    todoid = Column(Integer, primary_key=True, autoincrement=True)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), nullable=False)
    thing = Column(String(32), nullable=False)
    note = Column(String(255), nullable=True)
    completed = Column(Boolean, default=False)
    createdat = Column(DateTime, default=datetime.now())
    tocomplete = Column(DateTime, nullable=True)
    music = Column(String(255), nullable=True, default='Joy')
    repeat = Column(Boolean,nullable=False,default=False)
    # Relationships
    user = relationship('User', backref='todos')