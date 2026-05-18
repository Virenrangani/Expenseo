import 'package:expenseo/features/auth/presentation/widget/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../bottom_nav/app_bottom_nav.dart';
import 'log_in_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {

  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        isLoggedIn = false;
      });
      return;
    }

    try {
      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (refreshedUser == null) {
        setState(() {
          isLoggedIn = false;
        });
      } else {
        setState(() {
          isLoggedIn = true;
        });
      }

    } catch (e) {
      await FirebaseAuth.instance.signOut();
      setState(() {
        isLoggedIn = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    if (isLoggedIn == null) {
      return const Scaffold(
        body: Center(
          child: LoadingScreen(),
        ),
      );
    }

    return isLoggedIn!
        ? const AppBottomNav()
        : const LogInPage();
  }
}
