from sqlalchemy import Column, Integer, String, ForeignKey, Boolean, LargeBinary
from sqlalchemy.orm import relationship

from db.base import Base

class Title(Base):
    __tablename__ = 'titles'

    # Columns
    titleid = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(64), nullable=False)
    color = Column(String(64), nullable=False)
    categoryid = Column(Integer,ForeignKey('category.categoryId', ondelete='CASCADE'),nullable=False)
    levelreq = Column(Integer, nullable=True)
    description = Column(String(255), nullable=True)
    appdefault = Column(Boolean, nullable=False, default=False)
    icon = Column(Integer,ForeignKey('titlesicons.iconid', ondelete='CASCADE'),nullable=False)

    # Rels
    _category = relationship('Category',foreign_keys=[categoryid],backref='title_category')
    _icon = relationship('TitlesIcons',foreign_keys=[icon],backref='title_icon')