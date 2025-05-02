from fastapi import Depends
from typing import Annotated
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from base import Base
from db.models import (icon,users, titles, userTitles, roles
                       ,userRoles, toDo, groups, groupMembers, events
                       ,eventParticipants, groupTree, bubbleGroups, bubbleQuests,completedQuests,
                       notificationTypes, notifications, reports, category)

DATABASE_URL = "postgresql://admin:6Lpxd4hkS4E8s1IuxOA0WzCbWZgb@localhost/Orgit"

engine = create_engine(DATABASE_URL, echo=True)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base.metadata.create_all(bind=engine)

def createDBTables():
    Base.metadata.create_all(bind=engine)

def getDb():            
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()