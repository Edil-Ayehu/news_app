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

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height ?? (isTablet ? 40 : 32),
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 20 : 16,
          vertical: isTablet ? 8 : 6,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? ThemeConstants.primaryDark : ThemeConstants.primaryLight)
              : (isDark ? ThemeConstants.surfaceDark : ThemeConstants.surfaceLight),
          borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDark ? ThemeConstants.primaryDark : ThemeConstants.primaryLight).withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: (isTablet ? textTheme.labelLarge : textTheme.bodyMedium)?.copyWith(
            color: isSelected
                ? ThemeConstants.textPrimaryDark
                : (isDark ? ThemeConstants.textPrimaryDark : ThemeConstants.textPrimaryLight),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}