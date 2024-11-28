import 'package:flutter/material.dart';
import 'package:news_app/core/constants/theme_constants.dart';
import 'package:news_app/core/utils/helpers.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String author;
  final DateTime publishedAt;
  final String category;
  final VoidCallback onTap;
  final bool isSaved;
  final VoidCallback onSaveToggle;

  const ArticleCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.author,
    required this.publishedAt,
    required this.category,
    required this.onTap,
    this.isSaved = false,
    required this.onSaveToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Card(
      elevation: 0,
      color: isDark ? ThemeConstants.surfaceDark : ThemeConstants.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: isTablet ? 16 / 9 : 4 / 3,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: isDark ? ThemeConstants.surfaceDark : ThemeConstants.surfaceLight,
                      child: Icon(
                        Icons.image_not_supported,
                        color: isDark ? ThemeConstants.textSecondaryDark : ThemeConstants.textSecondaryLight,
                        size: 32,
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and Save Button Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark ? ThemeConstants.primaryDark : ThemeConstants.primaryLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          category,
                          style: textTheme.labelLarge?.copyWith(
                            color: ThemeConstants.textPrimaryDark,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: isDark ? ThemeConstants.primaryDark : ThemeConstants.primaryLight,
                        ),
                        onPressed: onSaveToggle,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Title
                  Text(
                    title,
                    style: textTheme.headlineMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Description
                  Text(
                    description,
                    style: textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Author and Date Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'By $author',
                          style: textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        Helpers.getTimeAgo(publishedAt),
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}