from sqlalchemy import Text, Column, Integer, String, Date, Boolean, LargeBinary, CHAR
from base import Base
from sqlalchemy.orm import relationship


class Icon(Base):
    __tablename__ = 'icon'
    # Columns
    iconid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(16), nullable=False)
    content = Column(Text, nullable=False)
    extension = Column(String(8), nullable=False)