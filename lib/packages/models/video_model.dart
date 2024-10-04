class VideoModel {
  final int id;
  final String file;
  final int authorId, likes, saved, reposts, soundId;
  final List<dynamic> comments;

  VideoModel(
      {required this.id,
      required this.file,
      required this.authorId,
      required this.likes,
      required this.saved,
      required this.reposts,
      required this.soundId,
      required this.comments
    });

  static var empty = VideoModel(
    id: 0, 
    file: "", 
    authorId: 0, 
    likes: 0, saved: 0, 
    reposts: 0, 
    soundId: 0, 
    comments: []
  );

  VideoModel copyWith({
    int? id,
    String? file,
    int? authorId, likes, saved, reposts, soundId,
    List<dynamic>? comments
  }) {
    return VideoModel(
      id: id ?? this.id,
      file: file ?? this.file,
      authorId: authorId ?? this.authorId,
      likes: likes ?? this.likes,
      saved: saved ?? this.saved,
      reposts: reposts ?? this.reposts,
      soundId : soundId ?? this.soundId,
      comments: comments ?? this.comments
    );
  }

  VideoModel.fromJson(Map<String, Object?> json) : this(
    id: json['id']! as int,
    file: json['file']! as String,
    authorId: json['author_id']! as int,
    likes: json['likes']! as int,
    saved: json['saved']! as int,
    reposts: json['reposts']! as int,
    soundId: json['sound_id']! as int,
    comments: json['comments']! as List<dynamic>
  );

  Map<String, Object?> toJson() {
    return {
      "id" : id,
      "file": file,
      "author_id" : authorId,
      "likes" : likes,
      "saved" : saved,
      "reposts" : reposts,
      "sound_id" : soundId,
      "comments" : comments
    };
  }

}
