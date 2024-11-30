import 'package:equatable/equatable.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/comment_model.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String description;
  final String content;
  final String author;
  final String? authorImageUrl;
  final String imageUrl;
  final String sourceUrl;
  final String sourceName;
  final Category category;
  final DateTime publishedAt;
  final int readTime;
  final int viewCount;
  final int likeCount;
  final int commentCount;
  final bool isBookmarked;
  final bool isLiked;
  final List<Comment> comments;
  final List<String> tags;

  const Article({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.author,
    this.authorImageUrl,
    required this.imageUrl,
    required this.sourceUrl,
    required this.sourceName,
    required this.category,
    required this.publishedAt,
    this.readTime = 0,
    this.viewCount = 0,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isBookmarked = false,
    this.isLiked = false,
    this.comments = const [],
    this.tags = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        content,
        author,
        authorImageUrl,
        imageUrl,
        sourceUrl,
        sourceName,
        category,
        publishedAt,
        readTime,
        viewCount,
        likeCount,
        commentCount,
        isBookmarked,
        isLiked,
        comments,
        tags,
      ];

  Article copyWith({
    String? id,
    String? title,
    String? description,
    String? content,
    String? author,
    DateTime? publishedAt,
    String? imageUrl,
    Category? category,
    int? readTime,
    bool? isBookmarked,
    String? sourceUrl,
    String? sourceName,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      author: author ?? this.author,
      publishedAt: publishedAt ?? this.publishedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      readTime: readTime ?? this.readTime,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      sourceName: sourceName ?? this.sourceName,
    );
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      authorImageUrl: json['author_image_url'] as String?,
      imageUrl: json['image_url'] as String,
      sourceUrl: json['source_url'] as String,
      sourceName: json['source_name'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      publishedAt: DateTime.parse(json['published_at'] as String),
      readTime: json['read_time'] as int? ?? 0,
      viewCount: json['view_count'] as int? ?? 0,
      likeCount: json['like_count'] as int? ?? 0,
      commentCount: json['comment_count'] as int? ?? 0,
      isBookmarked: json['is_bookmarked'] as bool? ?? false,
      isLiked: json['is_liked'] as bool? ?? false,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'author': author,
      if (authorImageUrl != null) 'author_image_url': authorImageUrl,
      'image_url': imageUrl,
      'source_url': sourceUrl,
      'source_name': sourceName,
      'category': category.toJson(),
      'published_at': publishedAt.toIso8601String(),
      'read_time': readTime,
      'view_count': viewCount,
      'like_count': likeCount,
      'comment_count': commentCount,
      'is_bookmarked': isBookmarked,
      'is_liked': isLiked,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'tags': tags,
    };
  }
}