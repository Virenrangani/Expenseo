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
          return const PinLockPage();
        }

        if (state is SecuritySetupRequired) {
          return const PinLockPage(isSetupMode: true);
        }

        if (state is SecurityAuthenticated || state is SecurityDisabled) {
          return child;
        }

        if (state is SecurityAuthenticated) {
          return child;
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
