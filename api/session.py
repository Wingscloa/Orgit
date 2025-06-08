from fastapi import Depends
from typing import Annotated
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from base import Base
import os
from pathlib import Path
from db.models import (icon,users, titles, userTitles, roles
                       ,userRoles, toDo, groups, groupMembers, events
                       ,eventParticipants, groupTree, bubbleGroups, bubbleQuests,completedQuests,
                       notificationTypes, notifications, reports, category, cities, regions)

# Načtení proměnných z .env souboru
env_path = Path(__file__).parent.parent / '.env'
config = {}
if env_path.exists():
    with open(env_path, encoding='utf-8') as f:
        for line in f:
            if '=' in line:
                key, value = line.strip().split('=', 1)
                config[key.strip()] = value.strip()
else:
    raise FileNotFoundError(f"Konfigurační soubor {env_path} nebyl nalezen.")

host = config.get('pSQLHost', 'localhost')
user = config.get('pSQLUser', 'postgres')
password = config.get('pSQLPassword', '')
db_name = config.get('DB_NAME', 'Orgit')

DATABASE_URL = f"postgresql://{user}:{password}@{host}/{db_name}"

engine = create_engine(DATABASE_URL, echo=True)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base.metadata.create_all(bind=engine)

def createDBTables():
    Base.metadata.create_all(bind=engine)

def getDb():            
    db = SessionLocal()
    print("Tralalero Tralala")
    try:
        yield db
    finally:
        db.close()