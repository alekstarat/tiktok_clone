from fastapi import FastAPI
from fastapi.responses import JSONResponse
from database import Database
import uvicorn

app = FastAPI()
db = Database("C:/Users/Sasher/Desktop/git/tiktok_clone/server/database.db")

def user_model(data):
    return JSONResponse(
        content={
                "id" : data[0],
                "login" : data[1],
                "password" : data[2],
                'name' : data[3],
                "description" : data[4],
                "image" : data[5],
                "subscribers" : data[6],
                "subscriptions" : data[7],
                "videos" : data[8],
                "reposts" : data[9],
                "saved" : data[10],
                "liked_videos" : data[11],
                "chats" : data[12],
                "settings" : data[13],
                "email" : data[14],
                "phone" : data[15],
                "birth" : data[16]
            }
    )

@app.get('/user/{id}')
async def get_user(id: int):
    try:
        data = list(db.cursor.execute(f"SELECT * FROM Users WHERE id = {id}"))[0]
        print(data)
        return JSONResponse(
            content={
                "id" : data[0],
                "login" : data[1],
                "password" : data[2],
                'name' : data[3],
                "description" : data[4],
                "image" : data[5],
                "subscribers" : data[6],
                "subscriptions" : data[7],
                "videos" : data[8],
                "reposts" : data[9],
                "saved" : data[10],
                "liked_videos" : data[11],
                "chats" : data[12],
                "settings" : data[13],
                "email" : data[14],
                "phone" : data[15],
                "birth" : data[16]
            }
        )
    except: 
        return JSONResponse(content={
            "status" : 400,
            'error_message' : "Что-то пошло не так"
        })

@app.post('/{method}/login')
async def login(name: str, password: str, method: str):
    try:
        data = list(db.cursor.execute(f'SELECT * FROM Users WHERE {method} = "{name}" AND password = "{password}"'))[0]
        return user_model(data)
    except: 
        return JSONResponse(content={
            'status' : 404,
            "error_message" : "Пользователь не найден, либо данные некорректны"
        })

if __name__ == '__main__':
    uvicorn.run("__main__:app", host='localhost', port=8000, reload=True, workers=3)