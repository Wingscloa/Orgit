import firebase_admin
from firebase_admin import credentials
from fastapi import FastAPI, Depends, HTTPException, Security
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
import firebase_admin.auth



app = FastAPI()
security = HTTPBearer()

cred = credentials.Certificate('./serviceAccountKey.json')
firebase_admin.initialize_app(cred)

def verify_firebase_token(auth: HTTPAuthorizationCredentials = Security(security)):
    try:
        token = auth.credentials
        decoded_token = firebase_admin.auth.verify_id_token(token, clock_skew_seconds=30)
        return decoded_token  # Obsah JWT tokenu (včetně uid)
    except Exception as e:
        raise HTTPException(status_code=401, detail=f"Invalid token: {str(e)}")