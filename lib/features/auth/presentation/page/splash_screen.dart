import 'package:flutter/material.dart';

import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../../bottom_nav/app_bottom_nav.dart';
import '../../../profile/presentation/page/complete_profile_page.dart';
import '../widget/loading_screen.dart';
import 'log_in_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool? isLoggedIn;
  bool? isProfileComplete;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    final hasSession = SharedPrefService.isLoggedIn();
    final profileComplete = SharedPrefService.isProfileComplete();

    setState(() {
      isLoggedIn = hasSession;
      isProfileComplete = profileComplete;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return const Scaffold(body: Center(child: LoadingScreen()));
    }

    if (!isLoggedIn!) {
      return const LogInPage();
    }

    if (!isProfileComplete!) {
      return CompleteProfilePage(userId: SharedPrefService.getUserId() ?? '');
    }

    return const AppBottomNav();
  }
}
