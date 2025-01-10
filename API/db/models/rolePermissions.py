from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from db.base import Base

class RolePermission(Base):
    __tablename__ = 'rolepermissions'

    # Foreign Keys
    roleid = Column(Integer, ForeignKey('roles.roleid', ondelete='CASCADE'), primary_key=True)
    permissionid = Column(Integer, ForeignKey('permissions.permissionid', ondelete='CASCADE'), primary_key=True)

    # Relationships
    role = relationship('Role', backref='role_permissions')
    permission = relationship('Permission', backref='role_permissions')
