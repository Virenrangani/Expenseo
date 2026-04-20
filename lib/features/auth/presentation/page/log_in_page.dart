import 'package:expenseo/features/auth/presentation/widget/log_in_title.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LogInTitle()
            ],
          )
      )
    );
  }
}
