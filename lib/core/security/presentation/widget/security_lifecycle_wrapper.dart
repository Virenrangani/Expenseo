import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/security_cubit.dart';

class SecurityLifecycleWrapper extends StatefulWidget {
  final Widget child;
  const SecurityLifecycleWrapper({super.key, required this.child});
  @override
  State<SecurityLifecycleWrapper> createState() =>
      _SecurityLifecycleWrapperState();
}

class _SecurityLifecycleWrapperState extends State<SecurityLifecycleWrapper>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      context.read<SecurityCubit>().lockApp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
