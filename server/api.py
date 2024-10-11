from fastapi import FastAPI, WebSocket
from fastapi.responses import JSONResponse, FileResponse
from database import Database
import uvicorn
import json

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
            'views' : data[9]
        }
    )

@app.websocket('/ws')
async def websocket(websocket: WebSocket):
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        
        await websocket.send_text(f"You said {data}")

@app.get('/profile_name_image/{id}')
async def get_profile_name_image(id: int):
    print(f"id = {id}")
    try:
        data = list(db.cursor.execute(f'SELECT image, name FROM Users WHERE id = {id}'))[0]
        
        print(data)
        return JSONResponse(
            content={
                "image" : data[0],
                'name' : data[1]
            }
        )
    except Exception as e:
        print(e)
        return JSONResponse(
            content={
                'status_code' : 400,
                'message' : "Писяка! >:P"
            }
        )

@app.post('/update/views')
async def update_views(videoId: int):
    try:
        db.cursor.execute(f"UPDATE Videos SET views = views + 1 WHERE id = {videoId}")
        db.connection.commit()
        print('+1 view')
    except:
        return JSONResponse(
            content={
                'status_code': 401,
                'message' : 'Ебалдяйкин'
            }
        )

@app.post('/set/like')
async def set_like(userId: int, videoId: int, value: str):
    try:
        db.cursor.execute(f"UPDATE Users SET liked_videos = '{value}' WHERE id = {userId}")
        db.cursor.execute(f"UPDATE Videos SET likes = likes + 1 WHERE id = {videoId}")
        db.connection.commit()
        print('Success!')
    except: 
        return JSONResponse(
            content={
                'status_code' : 500,
                'message' : 'Залупень'
            }
        )

@app.post('/unset/like')
async def unset_like(userId: int, videoId: int, value: str):
    try:
        db.cursor.execute(f"UPDATE Users SET liked_videos = '{value}' WHERE id = {userId}")
        db.cursor.execute(f"UPDATE Videos SET likes = likes - 1 WHERE id = {videoId}")
        db.connection.commit()
        print('Success!')
    except: 
        return JSONResponse(
            content={
                'status_code' : 500,
                'message' : 'Залупень'
            }
        )

@app.get('/video/{id}')
async def get_video(id: int):
    try: 
        data = list(db.cursor.execute(f"SELECT * FROM Videos WHERE id = {id}"))[0]
        print(data)
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

@app.post('/{method}/registration')
async def registration(name: str, password: str, birth: str, method: str):
    try:
        users = list(db.cursor.execute("SELECT * FROM Users"))
        print(users)

        for i in users:
            if  (method == 'login' and i[1] == name) or (method == 'email' and i[14] == name) or (method == 'phone' and i[15] == name) :
                return JSONResponse(
                    content={
                        'status_code' : 400,
                        'message' : "Йобу дал занят логин >:D"
                    }
                )
        else: 
            db.cursor.execute("INSERT INTO Users (login, password, name, description, image, subscribers, subscriptions, videos, reposts, saved, liked_videos, chats, settings, email, phone, birthday) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
            (
                name if method == 'login' else f'user{len(users)+1}',
                password,
                name if method == 'login' else name.split('@')[0] if method == 'email' else f'user{len(users)+1}',
                "",
                "",
                '[]',
                '[]',
                '[]',
                '[]',
                '{"publishes" : [], "collections" : [], "music" : [], "effects" : [], "shop_items" : [], "places" : [], "films" : [], "books" : [], "comments" : [], "hashtags" : [], "tt_series" : []}',
                '[]',
                '[]',
                '{}',
                name if method == 'email' else "",
                name if method == 'phone' else "",
                birth
            ))
            db.connection.commit()
            return user_model(list(db.cursor.execute(f'SELECT * FROM Users WHERE id = {len(users) + 1}'))[0])
    except Exception as e:
        print(e); 
        return JSONResponse(
            content={
                "message" : "Проёб запроса сученька"
            }
        )
    
@app.post('/unsubscribe')
async def unsubscribe(idFrom: int, idTo: int):
    try:
        valFrom = json.loads(list(db.cursor.execute(f'SELECT subscriptions FROM Users WHERE id = {idFrom}'))[0][0])
        valFrom = [i for i in valFrom if i != idTo]
        
        valTo = json.loads(list(db.cursor.execute(f'SELECT subscribers FROM Users WHERE id = {idTo}'))[0][0])
        valTo = [i for i in valTo if i != idFrom]

        db.cursor.execute(f'UPDATE Users SET subscriptions = "{valFrom}" WHERE id = {idFrom}')
        db.cursor.execute(f'UPDATE Users SET subscribers = "{valTo}" WHERE id = {idTo}')

        db.connection.commit()

        return JSONResponse(
            content = {
                'status_code' : 200,
                "message" : "success!"
            }
        )
    except Exception as e: 
        print(e)
        return JSONResponse(
            content = {
                'status_code' : 400,
                'message' : 'астралопитек быля'
            }
        )

@app.post('/subscribe')
async def subscribe(idFrom: int, idTo: int):
    try:
        valFrom = json.loads(list(db.cursor.execute(f'SELECT subscriptions FROM Users WHERE id = {idFrom}'))[0][0])
        valFrom.append(idTo)

        valTo = json.loads(list(db.cursor.execute(f'SELECT subscribers FROM Users WHERE id = {idTo}'))[0][0])
        valTo.append(idFrom)
        db.cursor.execute(f"UPDATE Users SET subscriptions = '{valFrom}' WHERE id = {idFrom}")
        db.cursor.execute(f"UPDATE Users SET subscribers = '{valTo}' WHERE id = {idTo}")

        db.connection.commit()

        return JSONResponse(
            content = {
                'status_code' : 200,
                "message" : "success!"
            }
        )
    except Exception as e:
        print(e)
        return JSONResponse(
            content = {
                'status_code' : 400,
                'message' : 'астралопитек быля'
            }
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