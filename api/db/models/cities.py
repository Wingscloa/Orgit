from sqlalchemy import Text, Column, Integer, String, Date, Boolean, LargeBinary, CHAR, ForeignKey
from sqlalchemy.orm import relationship
from base import Base
from datetime import datetime

class Cities(Base):
    __tablename__ = 'cities'
    # Columns
    cityid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(32), nullable=False, unique=True, index=True)
    regionid = Column(Integer, ForeignKey('regions.regionid', ondelete='CASCADE'), primary_key=False)
    
    # Relationships
    region = relationship('Regions', foreign_keys=[regionid], backref='region_cities')
