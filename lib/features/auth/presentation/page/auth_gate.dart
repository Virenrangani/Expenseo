import 'package:flutter/material.dart';

import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../../bottom_nav/app_bottom_nav.dart';
import '../widget/loading_screen.dart';
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
    final hasSession = await SharedPrefService.isLoggedIn();

    setState(() {
      isLoggedIn = hasSession;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return const Scaffold(body: Center(child: LoadingScreen()));
    }

    return isLoggedIn! ? const AppBottomNav() : const LogInPage();
  }
}
