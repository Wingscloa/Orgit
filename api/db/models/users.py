from sqlalchemy import Text, Column, Integer, String, Date, Boolean, LargeBinary, CHAR
from base import Base
from datetime import datetime

class User(Base):
    __tablename__ = 'users'
    # Columns
    userid = Column(Integer, primary_key=True, autoincrement=True)
    useruid = Column(String(255), nullable=False)
    firstname = Column(String(32), nullable=True)
    lastname = Column(String(32), nullable=True)
    nickname = Column(String(32), nullable=True)
    email = Column(String(64), nullable=False, unique=True, index=True)
    birthday = Column(Date, nullable=True)
    verified = Column(Boolean, nullable=False, default=False)
    deleted = Column(Boolean, nullable=False, default=False)
    telephonenumber = Column(CHAR(9), nullable=True)
    telephoneprefix = Column(CHAR(3), nullable=True)
    level = Column(Integer, nullable=False, default=1)
    experience = Column(Integer, nullable=False, default=0)
    profileicon = Column(LargeBinary, nullable=True)  # Changed from Text to LargeBinary for BYTEA
    deletedat = Column(Date, nullable=True)
    createdat = Column(Date, nullable=True, default=datetime.now())
    lastactive = Column(Date, nullable=True)


