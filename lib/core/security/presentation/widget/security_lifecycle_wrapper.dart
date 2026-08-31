import 'package:flutter/material.dart';

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
    // Manual app locking is disabled. Android system/app lock handles
    // background and lock states, so the app should not lock itself here.
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
