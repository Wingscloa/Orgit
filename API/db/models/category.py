from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from base import Base

class Category(Base):
    __tablename__ = 'category'

    # Columns
    categoryId = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(16), nullable=False)
