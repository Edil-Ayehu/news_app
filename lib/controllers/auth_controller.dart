import 'package:get/get.dart';
import 'package:news_app/core/services/firebase_service.dart';
import 'package:news_app/models/user_model.dart';

class AuthController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final Rx<User?> _user = Rx<User?>(null);
  
  User? get user => _user.value;
  bool get isAuthenticated => _user.value != null;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_firebaseService.authStateChanges);
  }

 // Sign in with email and password
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  // Register with email and password
  Future<void> register(String email, String password, String username) async {
    try {
      await _firebaseService.createUserWithEmailAndPassword(
        email,
        password,
        username,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _firebaseService.signOut();
    } catch (e) {
      rethrow;
    }
  }
}