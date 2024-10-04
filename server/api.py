from fastapi import FastAPI
from fastapi.responses import JSONResponse, FileResponse
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

def video_model(data):
    return JSONResponse(
        content={
            "id" : data[0],
            "file" : None,
            "author_id" : data[2],
            "likes" : data[3],
            "comments" : data[4],
            "saved" : data[5],
            "reposts" : data[6],
            "sound_id" : data[7],
            "name" : data[8],
        }
    )

@app.get('/profile_name_image/{id}')
async def get_profile_name_image(id: int):
    try:
        data = list(db.cursor.execute(f'SELECT image, name FROM Users WHERE id = {id}'))[0]
        print(data)
        return JSONResponse(
            content={
                "image" : data[0],
                'name' : data[1]
            }
        )
    except:
        return JSONResponse(
            content={
                'status_code' : 400,
                'message' : "Писяка! >:P"
            }
        )

@app.get('/video/{id}')
async def get_video(id: int):
    try: 
        data = list(db.cursor.execute(f"SELECT * FROM Videos WHERE id = {id}"))[0]
        return video_model(data)
    except:
        return JSONResponse(
            content={
                'status_code' : 400,
                'message' : 'Хуита'
            }
        )

@app.get('/video/raw/{id}')
async def get_video_raw(id: str): 
    try:
        return FileResponse(
            #f"C:/Users/Sasher/Desktop/git/tiktok_clone/server/videos/{id}.mp4"
            path=f"videos/{id}.mp4",
            media_type='video/mp4'
        )
    except: 
        return JSONResponse(
            content={
                "status_code": 404,
                "message": "Гавно"
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

@app.get('/image/{name}')
async def get_image(name: str):
    return FileResponse(
        f'images/{name}'
    )

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