from sqlalchemy import Column, Integer, ForeignKey, String, TIMESTAMP, Boolean
from sqlalchemy.orm import relationship
from db.base import Base

class Notification(Base):
    __tablename__ = 'notifications'

    # Columns
    notificationid = Column(Integer, primary_key=True, autoincrement=True)
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), nullable=False)
    notificationtypeid = Column(Integer, ForeignKey('notificationtypes.notificationtypeid', ondelete='CASCADE'), nullable=False)
    message = Column(String(255), nullable=False)
    createdat = Column(TIMESTAMP, default='CURRENT_TIMESTAMP')
    read = Column(Boolean, nullable=False, default=False)

    # Relationships
    user = relationship('User', backref='notifications')
    notification_type = relationship('NotificationType', backref='notifications')
