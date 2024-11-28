import 'package:equatable/equatable.dart';
import 'package:news_app/core/constants/app_constants.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String? icon;
  final String? description;
  final int articleCount;
  final bool isSelected;

  const Category({
    required this.id,
    required this.name,
    this.icon,
    this.description,
    this.articleCount = 0,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [id, name, icon, description, articleCount, isSelected];

  Category copyWith({
    String? id,
    String? name,
    String? icon,
    String? description,
    int? articleCount,
    bool? isSelected,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      articleCount: articleCount ?? this.articleCount,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String?,
      description: json['description'] as String?,
      articleCount: json['article_count'] as int? ?? 0,
      isSelected: json['is_selected'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (icon != null) 'icon': icon,
      if (description != null) 'description': description,
      'article_count': articleCount,
      'is_selected': isSelected,
    };
  }

  static List<Category> defaultCategories() {
    return AppConstants.newsCategories.map((name) {
      return Category(
        id: name.toLowerCase(),
        name: name,
        isSelected: name == 'All',
      );
    }).toList();
  }
}