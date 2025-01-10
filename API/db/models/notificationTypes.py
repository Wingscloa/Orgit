from sqlalchemy import Column, Integer, String
from db.base import Base

class NotificationType(Base):
    __tablename__ = 'notificationtypes'

    # Columns
    notificationtypeid = Column(Integer, primary_key=True, autoincrement=True)
    typename = Column(String(64), nullable=False, unique=True)
    description = Column(String(255), nullable=True)
