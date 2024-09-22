import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_google/bloc/auth/auth_state.dart';
import 'package:login_google/pages/home_page.dart';
import 'package:login_google/pages/login_or_register_page.dart';

import '../bloc/auth/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.isAuthenticated) {
          return HomePage();
        } else {
          return const LoginOrRegisterPage();
        }
      },
    );
  }
}
