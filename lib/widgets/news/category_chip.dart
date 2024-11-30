import 'package:flutter/material.dart';
import 'package:news_app/core/constants/theme_constants.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double? height;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: height ?? (isTablet ? 36 : 32),
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 24 : 20,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? ThemeConstants.primaryDark : ThemeConstants.primaryLight).withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected
                  ? (isDark ? ThemeConstants.primaryDark : ThemeConstants.primaryLight)
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: (isTablet ? textTheme.labelLarge : textTheme.labelMedium)?.copyWith(
                color: isSelected
                    ? (isDark ? ThemeConstants.primaryDark : ThemeConstants.primaryLight)
                    : (isDark ? ThemeConstants.textSecondaryDark : ThemeConstants.textSecondaryLight),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}