import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';

enum UserRole { veterinarian, petOwner }

class AuthProvider with ChangeNotifier {
  late AuthService _authService;
  bool _isLoading = false;
  User? _user;
  UserRole? _userRole;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  User? get user => _user;
  UserRole? get userRole => _userRole;
  String? get errorMessage => _errorMessage;

  void update(AuthService authService) {
    _authService = authService;
    _user = _authService.currentUser;
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    if (_user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .get();
        
        if (doc.exists && doc.data()?['role'] != null) {
          _userRole = doc.data()!['role'] == 'veterinarian'
              ? UserRole.veterinarian
              : UserRole.petOwner;
          notifyListeners();
        }
      } catch (e) {
        print('Error loading user role: $e');
      }
    }
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final credential = await _authService.signInWithEmail(email, password);
      _user = credential?.user;
      await _loadUserRole();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _handleAuthError(e);
      return false;
    }
  }

  Future<bool> register(String email, String password, UserRole role) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final credential = await _authService.registerWithEmail(email, password);
      _user = credential?.user;
      
      if (_user != null) {
        // Store user role in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .set({
          'email': email,
          'role': role == UserRole.veterinarian ? 'veterinarian' : 'petOwner',
          'createdAt': FieldValue.serverTimestamp(),
        });
        
        _userRole = role;
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _handleAuthError(e);
      return false;
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _authService.signOut();
      _user = null;
      _userRole = null;
    } catch (e) {
      _handleAuthError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _handleAuthError(dynamic error) {
    _isLoading = false;
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          _errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          _errorMessage = 'Wrong password provided.';
          break;
        case 'email-already-in-use':
          _errorMessage = 'Email is already registered.';
          break;
        case 'invalid-email':
          _errorMessage = 'Invalid email address.';
          break;
        case 'weak-password':
          _errorMessage = 'Password is too weak.';
          break;
        default:
          _errorMessage = 'An error occurred. Please try again.';
      }
    } else {
      _errorMessage = 'An unexpected error occurred.';
    }
    notifyListeners();
  }
}
