import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:news_app/models/user_model.dart';

class FirebaseService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  User? _userFromFirebase(firebase_auth.User? user) {
    if (user == null) return null;
    
    return User(
      id: user.uid,
      email: user.email!,
      username: user.displayName ?? user.email!.split('@')[0],
      isEmailVerified: user.emailVerified,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
      lastLoginAt: user.metadata.lastSignInTime,
    );
  }

  Stream<User?> get authStateChanges => 
      _auth.authStateChanges().map(_userFromFirebase);

  User? get currentUser => _userFromFirebase(_auth.currentUser);

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(result.user);
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> createUserWithEmailAndPassword(
    String email, 
    String password,
    String username,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await result.user?.updateDisplayName(username);
      return _userFromFirebase(result.user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}