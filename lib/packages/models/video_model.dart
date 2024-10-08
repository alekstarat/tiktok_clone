import 'dart:convert';

class VideoModel {
  final int id;
  final String name;
  final String? file;
  final int authorId, likes, saved, reposts, soundId, views;
  final List<dynamic> comments;

  VideoModel(
      {required this.id,
      required this.file,
      required this.name,
      required this.authorId,
      required this.likes,
      required this.saved,
      required this.reposts,
      required this.soundId,
      required this.comments,
      required this.views
    });

  static var empty = VideoModel(
    id: 0, 
    file: null, 
    name: "",
    authorId: 0, 
    likes: 0, saved: 0, 
    reposts: 0, 
    soundId: 0, 
    comments: [],
    views: 0
  );

  VideoModel copyWith({
    int? id,
    String? file, name,
    int? authorId, likes, saved, reposts, soundId, views,
    List<dynamic>? comments
  }) {
    return VideoModel(
      id: id ?? this.id,
      file: file ?? this.file,
      name: name ?? this.name,
      authorId: authorId ?? this.authorId,
      likes: likes ?? this.likes,
      saved: saved ?? this.saved,
      reposts: reposts ?? this.reposts,
      soundId : soundId ?? this.soundId,
      comments: comments ?? this.comments,
      views: views ?? this.views,
    );
  }

  VideoModel.fromJson(Map<String, Object?> json) : this(
    id: json['id']! as int,
    file: json['file'] as String?,
    name: json['name']! as String,
    authorId: json['author_id']! as int,
    likes: json['likes']! as int,
    saved: json['saved']! as int,
    reposts: json['reposts']! as int,
    soundId: json['sound_id']! as int,
    comments: jsonDecode(json['comments']! as String) as List<dynamic>,
    views: json['views']! as int,
  );

  Map<String, Object?> toJson() {
    return {
      "id" : id,
      "file": file,
      'name' : name,
      "author_id" : authorId,
      "likes" : likes,
      "saved" : saved,
      "reposts" : reposts,
      "sound_id" : soundId,
      "comments" : comments,
      "views" : views
    };
  }

}
