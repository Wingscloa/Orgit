from sqlalchemy import Column, Integer, String

from db.base import Base

class TitlesIcons(Base):
    __tablename__ = 'titlesicons'

    # Columns
    iconid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(64), nullable=False, unique=True)
    assetpath = Column(String(64), nullable=False)

