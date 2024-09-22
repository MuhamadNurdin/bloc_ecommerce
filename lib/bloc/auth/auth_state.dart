// auth_state.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final User? user;
  final bool isAuthenticated;

  AuthState({required this.user, required this.isAuthenticated});
}
