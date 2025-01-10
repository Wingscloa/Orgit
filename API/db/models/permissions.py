from sqlalchemy import Column, Integer, String
from db.base import Base

class Permission(Base):
    __tablename__ = 'permissions'

    # Columns
    permissionid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(32), nullable=False, unique=True)
    description = Column(String(255), nullable=False)
