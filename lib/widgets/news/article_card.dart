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
                aspectRatio: 16 / 9,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
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
                            style: textTheme.labelSmall?.copyWith(
                              color: ThemeConstants.textPrimaryDark,
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: isDark ? ThemeConstants.primaryDark : ThemeConstants.primaryLight,
                            size: 20,
                          ),
                          onPressed: onSaveToggle,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Title
                    Text(
                      title,
                      style: (isTablet ? textTheme.titleMedium : textTheme.titleSmall)?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Description
                    Expanded(
                      child: Text(
                        description,
                        style: (isTablet ? textTheme.bodyMedium : textTheme.bodySmall)?.copyWith(
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    // Author and Date Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'By $author',
                            style: textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          Helpers.getTimeAgo(publishedAt),
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}