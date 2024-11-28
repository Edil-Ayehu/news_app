import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  final String? bio;
  final List<String> savedArticles;
  final List<String> interests;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final UserPreferences preferences;

  const User({
    required this.id,
    required this.email,
    required this.username,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.bio,
    this.savedArticles = const [],
    this.interests = const [],
    this.isEmailVerified = false,
    required this.createdAt,
    this.lastLoginAt,
    this.preferences = const UserPreferences(),
  });

  String get fullName => [firstName, lastName]
      .where((name) => name != null && name.isNotEmpty)
      .join(' ');

  String get initials {
    if (firstName != null && lastName != null) {
      return '${firstName![0]}${lastName![0]}'.toUpperCase();
    }
    return username[0].toUpperCase();
  }

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        firstName,
        lastName,
        avatarUrl,
        bio,
        savedArticles,
        interests,
        isEmailVerified,
        createdAt,
        lastLoginAt,
        preferences,
      ];

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? avatarUrl,
    String? bio,
    List<String>? savedArticles,
    List<String>? interests,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    UserPreferences? preferences,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      savedArticles: savedArticles ?? this.savedArticles,
      interests: interests ?? this.interests,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      preferences: preferences ?? this.preferences,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
      savedArticles: (json['saved_articles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      interests: (json['interests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isEmailVerified: json['is_email_verified'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.parse(json['last_login_at'] as String)
          : null,
      preferences: json['preferences'] != null
          ? UserPreferences.fromJson(json['preferences'] as Map<String, dynamic>)
          : const UserPreferences(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (bio != null) 'bio': bio,
      'saved_articles': savedArticles,
      'interests': interests,
      'is_email_verified': isEmailVerified,
      'created_at': createdAt.toIso8601String(),
      if (lastLoginAt != null) 'last_login_at': lastLoginAt!.toIso8601String(),
      'preferences': preferences.toJson(),
    };
  }
}

class UserPreferences extends Equatable {
  final bool isDarkMode;
  final String language;
  final bool pushNotifications;
  final bool emailNotifications;
  final List<String> preferredCategories;

  const UserPreferences({
    this.isDarkMode = false,
    this.language = 'en',
    this.pushNotifications = true,
    this.emailNotifications = true,
    this.preferredCategories = const [],
  });

  @override
  List<Object?> get props => [
        isDarkMode,
        language,
        pushNotifications,
        emailNotifications,
        preferredCategories,
      ];

  UserPreferences copyWith({
    bool? isDarkMode,
    String? language,
    bool? pushNotifications,
    bool? emailNotifications,
    List<String>? preferredCategories,
  }) {
    return UserPreferences(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      preferredCategories: preferredCategories ?? this.preferredCategories,
    );
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      isDarkMode: json['is_dark_mode'] as bool? ?? false,
      language: json['language'] as String? ?? 'en',
      pushNotifications: json['push_notifications'] as bool? ?? true,
      emailNotifications: json['email_notifications'] as bool? ?? true,
      preferredCategories: (json['preferred_categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_dark_mode': isDarkMode,
      'language': language,
      'push_notifications': pushNotifications,
      'email_notifications': emailNotifications,
      'preferred_categories': preferredCategories,
    };
  }
}