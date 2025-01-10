from sqlalchemy import Column, Integer, String, ForeignKey, LargeBinary
from sqlalchemy.orm import relationship
from db.base import Base

class BubbleGroup(Base):
    __tablename__ = 'bubblegroups'

    # Columns
    bubblegroupid = Column(Integer, primary_key=True, autoincrement=True)
    treeid = Column(Integer, ForeignKey('grouptree.treeid', ondelete='CASCADE'), nullable=False)
    name = Column(String(64), nullable=False)
    icon = Column(LargeBinary, nullable=False)
    unlockaftercomplete = Column(Integer, ForeignKey('bubblegroups.bubblegroupid', ondelete='CASCADE'), nullable=True)
    levelreq = Column(Integer, nullable=True)

    # Relationships
    grouptree = relationship('GroupTree',foreign_keys=[treeid], backref='bubble_groups')
    unlockafter = relationship('BubbleGroup', remote_side=[bubblegroupid], backref='unlocking_groups')