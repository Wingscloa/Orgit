from sqlalchemy import Column, Integer, ForeignKey, String, TIMESTAMP, Boolean
from sqlalchemy.orm import relationship
from db.base import Base
from datetime import datetime

class Report(Base):
    __tablename__ = 'reports'

    # Columns
    reportid = Column(Integer, primary_key=True, autoincrement=True)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), nullable=False)
    messageid = Column(Integer, ForeignKey('messages.messageid', ondelete='CASCADE'), nullable=False)
    reporttype = Column(String(32), nullable=False)
    note = Column(String(512), nullable=False)
    resolved = Column(Boolean, nullable=False, default=False)
    resolver = Column(Integer, ForeignKey('users.userid'), nullable=True)
    createdat = Column(TIMESTAMP, default=datetime.now())

    # Relationships
    user = relationship('User',foreign_keys=[userid], backref='reports')
    message = relationship('Message',foreign_keys=[messageid], backref='reports')
    resolvers = relationship('User', foreign_keys=[resolver], backref='resolved_reports')
