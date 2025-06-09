from sqlalchemy import Text, Column, Integer, String, Date, Boolean, LargeBinary, CHAR
from base import Base
from datetime import datetime

class Regions(Base):
    __tablename__ = 'regions'
    # Columns
    regionid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(32), nullable=False, unique=True, index=True)