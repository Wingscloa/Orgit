from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from db.base import Base
from datetime import datetime



class ToDo(Base):
    __tablename__ = 'todo'

    # Columns
    todoid = Column(Integer, primary_key=True, autoincrement=True)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), nullable=False)
    note = Column(String(255), nullable=False)
    quantity = Column(Integer, nullable=True)
    completed = Column(Boolean, default=False)
    createdat = Column(DateTime, default=datetime.now())

    # Relationships
    user = relationship('User', backref='todos')