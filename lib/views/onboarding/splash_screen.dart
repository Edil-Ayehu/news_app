import 'package:flutter/material.dart';
import 'package:news_app/views/news/news_feed_view.dart';
import 'package:news_app/views/onboarding/onboarding_screen.dart';
import 'package:news_app/views/auth/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/auth_controller.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _navigateToNextScreen();
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  Future<void> _navigateToNextScreen() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isFirstTime = prefs.getBool('is_first_time') ?? true;

      await Future.wait([
        Future.delayed(const Duration(seconds: 2)),
        _controller.forward().orCancel,
      ]);

      if (!mounted) return;

      if (isFirstTime) {
        Get.off(() => const OnboardingScreen());
      } else if (_authController.isAuthenticated) {
        Get.off(() => const NewsFeedView());
      } else {
        Get.off(() => const LoginView());
      }
    } catch (e) {
      debugPrint('Navigation error: $e');
      if (mounted) {
        Get.off(() => const LoginView());
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.article_outlined,
                size: 80,
                color: isDark ? Colors.white : Colors.black,
              ),
              const SizedBox(height: 24),
              Text(
                'News App',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
