from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from db.base import Base



class UserTitle(Base):
    __tablename__ = 'usertitles'

    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), primary_key=True)
    titleid = Column(Integer, ForeignKey('titles.titleid', ondelete='CASCADE'), primary_key=True)

    # Relationships
    user = relationship('User', backref='usertitles')
    title = relationship('Title', backref='usertitles')
