import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String author;
  final String content;
  final DateTime timestamp;
  final String? avatarUrl;
  final int likes;
  final bool isLiked;

  const Comment({
    required this.id,
    required this.author,
    required this.content,
    required this.timestamp,
    this.avatarUrl,
    this.likes = 0,
    this.isLiked = false,
  });

  @override
  List<Object?> get props => [
        id,
        author,
        content,
        timestamp,
        avatarUrl,
        likes,
        isLiked,
      ];

  Comment copyWith({
    String? id,
    String? author,
    String? content,
    DateTime? timestamp,
    String? avatarUrl,
    int? likes,
    bool? isLiked,
  }) {
    return Comment(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      author: json['author'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      avatarUrl: json['avatar_url'] as String?,
      likes: json['likes'] as int? ?? 0,
      isLiked: json['is_liked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      'likes': likes,
      'is_liked': isLiked,
    };
  }
}