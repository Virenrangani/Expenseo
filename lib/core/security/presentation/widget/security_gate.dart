import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/auth/presentation/page/pin_lock/pin_lock_page.dart';
import '../../logic/security_cubit.dart';
import '../../logic/security_state.dart';

class SecurityGate extends StatelessWidget {
  final Widget child;
  const SecurityGate({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecurityCubit, SecurityState>(
      builder: (context, state) {
        if (state is SecurityLocked) {
          // App is locked, show the PIN unlock screen
          return const PinLockPage();
        }

        if (state is SecuritySetupRequired) {
          // No PIN set up yet, show the PIN creation screen
          return const PinLockPage(isSetupMode: true);
        }

        // Update this line in SecurityGate's build method
        if (state is SecurityAuthenticated || state is SecurityDisabled) {
          return child;
        }

        if (state is SecurityAuthenticated) {
          // User is authorized, show the actual app content
          return child;
        }

        // Initializing state or fallback
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
