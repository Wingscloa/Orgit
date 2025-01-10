from sqlalchemy import Column, Integer, String, Enum, ForeignKey
from db.base import Base

from enum import Enum as PyEnum

class TitleGroup(PyEnum):
    specials = 'specials'
    achievements = 'achievements'
    level = 'level'
    unique = 'unique'

class Title(Base):
    __tablename__ = 'titles'

    # Columns
    titleid = Column(Integer, primary_key=True, autoincrement=True)
    titlename = Column(String(64), nullable=False, unique=True)
    titlecolor = Column(String(64), nullable=False)
    titlegroup = Column(Enum(TitleGroup), nullable=False)
    levelreq = Column(Integer, nullable=True)
    description = Column(String(255), nullable=True)
