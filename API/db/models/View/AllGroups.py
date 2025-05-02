# Only Name and His Profile for searching
from sqlalchemy import Column, Text, String, Integer
from base import Base

class AllGroups(Base):
    __tablename__ = "allgroups"

    groupid = Column(Integer, primary_key=True)
    name = Column(String(32), nullable=False)
    profilepicture = Column(Text, nullable=False)
    city = Column(String(32), nullable=False)