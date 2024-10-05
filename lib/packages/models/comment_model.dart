import 'dart:convert';

class CommentModel {
  final int authorId, likes;
  final DateTime? date;
  final String text;
  final List<CommentModel> replies;

  CommentModel(
      {required this.authorId,
      required this.likes,
      required this.date,
      required this.text,
      required this.replies});

  static var empty =
      CommentModel(
        authorId: 0, 
        likes: 0, 
        date: null, 
        text: "", 
        replies: []
      );

  CommentModel copyWith({
    int? authorId, likes,
    DateTime? date,
    String? text,
    List<CommentModel>? replies,
  }) {
    return CommentModel(
      authorId: authorId ?? this.authorId, 
      likes: likes ?? this.likes, 
      date: date ?? this.date, 
      text: text ?? this.text, 
      replies: replies ?? this.replies
    );
  }

  CommentModel.fromJson(Map<String, Object?> json) : this(
    authorId: json['authorId']! as int,
    likes: json['likes']! as int,
    date: DateTime.parse(json['date'] as String) as DateTime?,
    text: json['text']! as String,
    replies: jsonDecode(json['replies']! as String) as List<CommentModel>
  );

  Map<String, Object?> toJson() {
    return {
      'authorId' : authorId,
      'likes' : likes,
      'date' : date,
      'text' : text,
      'replies' : replies
    };
  }

  
}
