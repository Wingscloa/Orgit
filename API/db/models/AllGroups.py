# Only Name and His Profile for searching
from sqlalchemy import Column, LargeBinary, String, Integer
from sqlalchemy.orm import relationship
from sqlalchemy.schema import Index
from db.base import Base

class AllGroups(Base):
    __tablename__ = "allgroups"

    groupid = Column(Integer, primary_key=True)
    name = Column(String(32))
    profilepic = Column(LargeBinary)