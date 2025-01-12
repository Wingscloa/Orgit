from sqlalchemy import Column, Integer, String, Date, Boolean, LargeBinary
from db.base import Base
from datetime import datetime

class User(Base):
    __tablename__ = 'users'

    # Columns
    userid = Column(Integer, primary_key=True, autoincrement=True)
    useruid = Column(String(255), nullable=False)
    firstname = Column(String(64), nullable=False)
    lastname = Column(String(64), nullable=False)
    nickname = Column(String(64), nullable=True)
    email = Column(String(128), nullable=False, unique=True, index=True)
    profileicon = Column(LargeBinary, nullable=True)
    deleted = Column(Boolean, nullable=False, default=False)
    deletedat = Column(Date, nullable=True)
    createdat = Column(Date, nullable=True, default=datetime.now())
    lastactive = Column(Date, nullable=True)
    telephonenumber = Column(String(15), nullable=True)
    telephoneprefix = Column(String(5), nullable=True)
    level = Column(Integer, nullable=False, default=1)
    experience = Column(Integer, nullable=False, default=0)
    settingsconfig = Column(LargeBinary, nullable=True)
    birthday = Column(Date, nullable=False)
    verified = Column(Boolean, nullable=False, default=False)
    onnotify = Column(Boolean, nullable=False, default=True)
    # Indexes
    __table_args__ = (
        # Index for Email column
        {'sqlite_autoincrement': True},
    )


