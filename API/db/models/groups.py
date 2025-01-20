from sqlalchemy import Column, Integer, String, ForeignKey, Date, LargeBinary
from sqlalchemy.orm import relationship
from ...db.base import Base
from datetime import datetime

class Group(Base):
    __tablename__ = 'groups'

    # Columns
    groupid = Column(Integer, primary_key=True, autoincrement=True)
    profilepic = Column(LargeBinary, nullable=False)
    name = Column(String(32), nullable=False)
    city = Column(String(32), nullable=False)
    region = Column(String(32), nullable=False)
    leader = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'))
    description = Column(String(512), nullable=False)
    createdby = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'))
    createdat = Column(Date, default=datetime.now())

    # Relationships
    leaders = relationship('User', foreign_keys=[leader], backref='leader_groups')
    creators = relationship('User', foreign_keys=[createdby], backref='created_groups')
