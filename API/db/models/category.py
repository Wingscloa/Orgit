from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship

from db.base import Base

class Category(Base):
    __tablename__ = 'category'

    # Columns
    categoryId = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(32), nullable=False)
