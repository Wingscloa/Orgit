from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from db.base import Base
from db.models import users
from db.models import titles
from db.models import userTitles
from db.models import permissions
from db.models import roles
from db.models import rolePermissions
from db.models import userRoles
from db.models import toDo
from db.models import groups
from db.models import groupMembers
from db.models import events
from db.models import eventItems
from db.models import eventParticipants
from db.models import groupTree
from db.models import bubbleGroups
from db.models import bubbleQuests
from db.models import completedQuests
from db.models import chat
from db.models import chatParticipants
from db.models import messages
from db.models import reactions
from db.models import notificationTypes
from db.models import notifications
from db.models import reports


DATABASE_URL = "postgresql://admin:6Lpxd4hkS4E8s1IuxOA0WzCbWZgb@localhost/Orgit"

engine = create_engine(DATABASE_URL, echo=True)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def createDBTables():
    Base.metadata.create_all(bind=engine)