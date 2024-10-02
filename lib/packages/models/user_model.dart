

import 'dart:convert';

class UserModel {


  final int id;
  final String login, password;
  final String? name, description, image, email, phone;
  final DateTime? birth;
  final List<dynamic> subscribers, subscriptions, videos, reposts, likedVideos, chats;
  final Map<String?, dynamic> settings, saved;

  const UserModel({
    required this.id, 
    required this.login, 
    required this.password, 
    required this.name, 
    required this.description, 
    required this.image, required this.email, 
    required this.phone, required this.birth, 
    required this.subscribers, 
    required this.subscriptions, 
    required this.videos, 
    required this.reposts, 
    required this.saved, 
    required this.likedVideos, 
    required this.chats, 
    required this.settings
  });

  static const empty = UserModel(
    id: 0, login: "", 
    password: "", name: "", 
    description: "", image: "", 
    email:"", phone:  "",
    birth: null, subscribers: [], 
    subscriptions: [], videos: [], 
    reposts: [], saved: {}, 
    likedVideos: [], chats: [], 
    settings: {});

  UserModel copyWith({
    int? id,
    String? login, password,
    String? name, description, image, email, phone,
    DateTime? birth,
    List<int?>? subscribers, subscriptions, videos, reposts, likedVideos, chats,
    Map<String?, dynamic>? settings, saved
  }) {
    return UserModel(
      id: id ?? this.id, 
      login: login ?? this.login, 
      password: password ?? this.password, 
      name: name ?? this.name, 
      description: description ?? this.description, 
      image: image ?? this.image, 
      email: email ?? this.email, 
      phone: phone ?? this.phone, 
      birth: birth ?? this.birth, 
      subscribers: subscribers ?? this.subscribers, 
      subscriptions: subscriptions ?? this.subscriptions,
      videos: videos ?? this.videos, 
      reposts: reposts ?? this.reposts, 
      saved: saved ?? this.saved, 
      likedVideos: likedVideos ?? this.likedVideos, 
      chats: chats ?? this.chats, 
      settings: settings ?? this.settings
    );
  }

  UserModel.fromJson(Map<String, Object?> json) : this(
    id: json['id']! as int,
    login: json['login']! as String,
    password: json['password']! as String,
    name: json['name']! as String?,
    description: json['description']! as String?,
    image: json['image']! as String?,
    email: json['email']! as String?,
    phone: json['phone']! as String?,
    birth: DateTime.parse(json['birth'] as String),
    subscribers: jsonDecode(json['subscribers']! as String) as List<dynamic>,
    subscriptions: jsonDecode(json['subscriptions']! as String) as List<dynamic>,
    videos: jsonDecode(json['videos']! as String) as List<dynamic>,
    reposts: jsonDecode(json['reposts']! as String) as List<dynamic>,
    saved: jsonDecode(json['saved']! as String) as Map<String?, dynamic>,
    likedVideos: jsonDecode(json['liked_videos']! as String) as List<dynamic>,
    chats: jsonDecode(json['chats']! as String) as List<dynamic>,
    settings: jsonDecode(json['settings']! as String) as Map<String?, dynamic>
  );

  Map<String, Object?> toJson() {
    return {
      "id" : id,
      "login" : login,
      "password" : password,
      "name" : name,
      "description": description,
      "image" : image,
      "email" : email,
      "phone" : phone,
      "birth" : birth,
      "subscribers" : subscribers,
      "subscriptions" : subscriptions,
      "videos" : videos,
      "reposts" : reposts,
      "saved" : saved,
      "liked_videos" : likedVideos,
      "chats" : chats,
      "settings" : settings
    };
  }


}