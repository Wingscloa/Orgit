from sqlalchemy import Column, Integer, String
from ...db.base import Base

class Role(Base):
    __tablename__ = 'roles'

    # Columns
    roleid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(32), nullable=False, unique=True)
    description = Column(String(255), nullable=True)
