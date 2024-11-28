class Comment {
  final String id;
  final String author;
  final String content;
  final DateTime timestamp;
  final String? avatarUrl;
  final int likes;
  final bool isLiked;

  Comment({
    required this.id,
    required this.author,
    required this.content,
    required this.timestamp,
    this.avatarUrl,
    this.likes = 0,
    this.isLiked = false,
  });
}