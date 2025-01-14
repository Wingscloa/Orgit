from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from db.base import Base
from db.models import (users, titles, userTitles, permissions, roles, rolePermissions
                       ,userRoles, toDo, groups, groupMembers, events, eventItems
                       ,eventParticipants, groupTree, bubbleGroups, bubbleQuests,
                       completedQuests, chat, chatParticipants, messages, reactions,
                       notificationTypes, notifications, reports, category, titlesIcons)


DATABASE_URL = "postgresql://admin:6Lpxd4hkS4E8s1IuxOA0WzCbWZgb@localhost/Orgit"

engine = create_engine(DATABASE_URL, echo=True)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base.metadata.create_all(bind=engine)

def createDBTables():
    Base.metadata.create_all(bind=engine)