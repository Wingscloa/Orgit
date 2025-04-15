from sqlalchemy import Column, Integer, VARCHAR, TIMESTAMP, BOOLEAN, ForeignKey
from sqlalchemy.orm import relationship
from base import Base
from datetime import datetime


class ToDo(Base):
    __tablename__ = 'todo'
    # Columns
    todoid = Column(Integer, primary_key=True, autoincrement=True)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), nullable=False)
    title = Column(VARCHAR(32), nullable=False)
    note = Column(VARCHAR(255), nullable=True)
    whencomplete = Column(TIMESTAMP, nullable=False)
    tocomplete = Column(TIMESTAMP, nullable=True)
    completed = Column(BOOLEAN, default=False)
    createdat = Column(TIMESTAMP, default=datetime.now())
    # Relationships
    user = relationship('User', backref='todos')