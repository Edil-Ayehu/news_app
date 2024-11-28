class AppConstants {
  // App Information
  static const String appName = 'News App';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String baseUrl = '';
  static const String apiVersion = '/v1';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';

  // Navigation Routes
  static const String homeRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String profileRoute = '/profile';
  static const String articleDetailRoute = '/article';
  static const String savedArticlesRoute = '/saved';
  static const String settingsRoute = '/settings';
  
  // Asset Paths
  static const String imagePath = 'assets/images';
  static const String iconPath = 'assets/icons';
  static const String defaultAvatar = '$imagePath/default_avatar.png';
  static const String appLogo = '$imagePath/app_logo.png';
  
  // Pagination
  static const int itemsPerPage = 10;
  static const int maxPageSize = 50;
  
  // Timeouts
  static const int connectionTimeout = 30000; // milliseconds
  static const int receiveTimeout = 30000; // milliseconds
  
  // Cache Duration
  static const int cacheDuration = 3600; // seconds (1 hour)
  
  // Validation Rules
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int maxUsernameLength = 50;
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 500;
  
  // Error Messages
  static const String networkError = 'Network connection error';
  static const String serverError = 'Server error occurred';
  static const String unauthorizedError = 'Unauthorized access';
  static const String validationError = 'Please check your input';
  
  // Success Messages
  static const String loginSuccess = 'Successfully logged in';
  static const String registerSuccess = 'Registration successful';
  static const String updateSuccess = 'Successfully updated';
  static const String saveSuccess = 'Successfully saved';
  
  // Categories
  static const List<String> newsCategories = [
    'All',
    'Business',
    'Technology',
    'Sports',
    'Entertainment',
    'Health',
    'Science',
    'Politics',
  ];
  
  // Date Formats
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'MMM dd, yyyy HH:mm';
  
  // Social Media
  static const String twitterUrl = 'https://twitter.com/newsapp';
  static const String facebookUrl = 'https://facebook.com/newsapp';
  static const String instagramUrl = 'https://instagram.com/newsapp';
  
  // Support
  static const String supportEmail = 'edilayehut@gmail.com';
  static const String privacyPolicyUrl = 'https://newsapp.com/privacy';
  static const String termsUrl = 'https://newsapp.com/terms';
}
