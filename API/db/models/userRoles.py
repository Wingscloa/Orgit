from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from db.base import Base


class UserRole(Base):
    __tablename__ = 'userroles'

    # Foreign Keys
    userid = Column(Integer, ForeignKey('users.userid', ondelete='CASCADE'), primary_key=True)
    roleid = Column(Integer, ForeignKey('roles.roleid', ondelete='CASCADE'), primary_key=True)

    # Relationships
    user = relationship('User', backref='user_roles')
    role = relationship('Role', backref='user_roles')
