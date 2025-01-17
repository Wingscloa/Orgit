from fastapi import FastAPI
from routes import (user_end,todo_end,email_end,
                    group_end,notification_end,
                    report_end,title_end,event_end)
# FastAPI

app = FastAPI()

app.include_router(user_end.router,tags=["User"])
app.include_router(todo_end.router,tags=["Todo"])
app.include_router(email_end.router,tags=["Email"])
app.include_router(group_end.router,tags=["Group"])
app.include_router(notification_end.router,tags=["Notification"])
app.include_router(report_end.router,tags=["Report"])
app.include_router(title_end.router,tags=["Title"])
app.include_router(event_end.router,tags=["Event"])