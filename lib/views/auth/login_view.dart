import 'package:flutter/material.dart';
import 'package:news_app/core/constants/theme_constants.dart';
import 'package:news_app/views/auth/register_view.dart';
import 'package:news_app/views/news/article_detail_view_.dart';
import 'package:news_app/widgets/common/custom_button.dart';
import 'package:news_app/widgets/common/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  final _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        setState(() => _isLoading = true);
        await _authController.signIn(
          _emailController.text.trim(),
          _passwordController.text,
        );
        Get.offAll(() => const NewsFeedView());
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to sign in: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: size.width > 600 ? 400 : double.infinity),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome Back',
                    style: (isDark
                            ? ThemeConstants.darkTextTheme
                            : ThemeConstants.lightTextTheme)
                        .headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    obscureText: _obscurePassword,
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: _obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onSuffixIconPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    label: 'Login',
                    isLoading: _isLoading,
                    isFullWidth: true,
                    onPressed: _handleLogin,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: (isDark
                                ? ThemeConstants.darkTextTheme
                                : ThemeConstants.lightTextTheme)
                            .bodyMedium,
                      ),
                      CustomButton(
                        label: 'Register',
                        type: CustomButtonType.text,
                        onPressed: () {
                          Get.to(() => const RegisterView());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
