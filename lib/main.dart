import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/constants/theme_constants.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/views/onboarding/splash_screen.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Initialize Auth Controller
  Get.put(AuthController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeConstants.lightTheme,
      darkTheme: ThemeConstants.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
