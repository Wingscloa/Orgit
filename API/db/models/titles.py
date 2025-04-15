from sqlalchemy import CHAR, Column, Integer, String, ForeignKey, Boolean, LargeBinary
from sqlalchemy.orm import relationship
from base import Base

class Title(Base):
    __tablename__ = 'titles'
    # Columns
    titleid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(32), nullable=False)
    categoryid = Column(Integer,ForeignKey('category.categoryId', ondelete='CASCADE'),nullable=False)
    color = Column(CHAR(6), nullable=False)
    iconid = Column(Integer,ForeignKey('icon.iconid', ondelete='CASCADE'),nullable=False)
    describe = Column(String(255), nullable=True)
    # Rels
    _category = relationship('Category',foreign_keys=[categoryid],backref='title_category')
    _icon = relationship('Icon', foreign_keys=[iconid], backref='title_icon')