import 'package:flutter/material.dart';
import 'package:news_app/core/constants/theme_constants.dart';

enum CustomButtonType { elevated, outlined, text }
enum CustomButtonSize { small, medium, large }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final CustomButtonType type;
  final CustomButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = CustomButtonType.elevated,
    this.size = CustomButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  Size _getButtonSize(CustomButtonSize size) {
    switch (size) {
      case CustomButtonSize.small:
        return const Size(64, 36);
      case CustomButtonSize.medium:
        return const Size(88, 48);
      case CustomButtonSize.large:
        return const Size(120, 56);
    }
  }

  EdgeInsets _getButtonPadding(CustomButtonSize size) {
    switch (size) {
      case CustomButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case CustomButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case CustomButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  Widget _buildLoadingIndicator(bool isDark) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          isDark ? ThemeConstants.textPrimaryDark : ThemeConstants.textPrimaryLight,
        ),
      ),
    );
  }

  Widget _buildButtonContent(bool isDark) {
    if (isLoading) {
      return _buildLoadingIndicator(isDark);
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label),
        ],
      );
    }

    return Text(label);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonSize = _getButtonSize(size);
    final buttonPadding = _getButtonPadding(size);

    Widget button;
    switch (type) {
      case CustomButtonType.elevated:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: (isDark ? ThemeConstants.elevatedButtonStyleDark : ThemeConstants.elevatedButtonStyleLight).copyWith(
            backgroundColor: WidgetStateProperty.all(backgroundColor),
            foregroundColor: WidgetStateProperty.all(foregroundColor),
            minimumSize: WidgetStateProperty.all(buttonSize),
            padding: WidgetStateProperty.all(buttonPadding),
          ),
          child: _buildButtonContent(isDark),
        );
        break;

      case CustomButtonType.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: (isDark ? ThemeConstants.outlinedButtonStyleDark : ThemeConstants.outlinedButtonStyleLight).copyWith(
            foregroundColor: WidgetStateProperty.all(foregroundColor),
            minimumSize: WidgetStateProperty.all(buttonSize),
            padding: WidgetStateProperty.all(buttonPadding),
          ),
          child: _buildButtonContent(isDark),
        );
        break;

      case CustomButtonType.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: (isDark ? ThemeConstants.textButtonStyleDark : ThemeConstants.textButtonStyleLight).copyWith(
            foregroundColor: WidgetStateProperty.all(foregroundColor),
            minimumSize: WidgetStateProperty.all(buttonSize),
            padding: WidgetStateProperty.all(buttonPadding),
          ),
          child: _buildButtonContent(isDark),
        );
        break;
    }

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}