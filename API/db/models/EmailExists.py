from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from sqlalchemy.schema import Index
from db.base import Base

class EmailExists(Base):
    __tablename__ = 'email_exists'

    email = Column(String(255), primary_key=True)
    email_count = Column(Integer)