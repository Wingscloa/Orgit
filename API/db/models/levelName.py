from sqlalchemy import Column, Integer, String, ForeignKey, Boolean, LargeBinary
from sqlalchemy.orm import relationship

from ...db.base import Base

class levelName(Base):
    __tablename__ = 'levelname'

    # Cols.
    levelid = Column(Integer, primary_key=True, autoincrement=True)
    groupid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), nullable=False)
    name = Column(String(16), nullable=False)
    levelreq = Column(Integer, nullable=False)

    # Rels
    _groupid = relationship('User', foreign_keys=[groupid], backref='group_levelnames')


