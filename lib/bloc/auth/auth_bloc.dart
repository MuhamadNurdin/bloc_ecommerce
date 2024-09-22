// auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState(user: null, isAuthenticated: false)) {
    on<AuthLoggedIn>(_onLoggedIn);
    on<AuthLoggedOut>(_onLoggedOut);

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        add(AuthLoggedIn());
      } else {
        add(AuthLoggedOut());
      }
    });
  }

  void _onLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) {
    emit(AuthState(user: FirebaseAuth.instance.currentUser, isAuthenticated: true));
  }

  void _onLoggedOut(AuthLoggedOut event, Emitter<AuthState> emit) {
    emit(AuthState(user: null, isAuthenticated: false));
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    add(AuthLoggedOut());
  }
}
