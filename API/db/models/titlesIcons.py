from sqlalchemy import Column, Integer, String, Text, LargeBinary

from ...db.base import Base

class TitlesIcons(Base):
    __tablename__ = 'titlesicons'

    # Columns
    iconid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(64), nullable=False, unique=True)
    path = Column(Text,nullable=True, unique=True)
    url = Column(String(255), nullable=True, unique=True)
    data = Column(LargeBinary, nullable=True, unique=True)


