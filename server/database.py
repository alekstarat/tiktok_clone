import sqlite3

class Database:

    def __init__(self, path):
        self.connection = sqlite3.connect(path)
        self.cursor = self.connection.cursor()
    

if __name__ == "__main__":
    db = Database("C:/Users/Sasher/Desktop/git/tiktok_clone/server/database.db")
    db.cursor.execute("INSERT INTO Users (login, password, name, description, image, subscribers, subscriptions, videos, reposts, saved, liked_videos, chats, settings, email, phone, birthday) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    ('alekstarat', '12345678', 'Сашка', "https://vk.com/raskrasska", '', '[]', '[]', '[]', '[]', '{"publishes" : [], "collections" : [], "music" : [], "effects" : [], "shop_items" : [], "places" : [], "films" : [], "books" : [], "comments" : [], "hashtags" : [], "tt_series" : []}', '[]', '[]', '{}', "alekstaratcode@gmail.com", "+79636544546", "18.10.2004"))
    db.connection.commit()
    db.connection.close()