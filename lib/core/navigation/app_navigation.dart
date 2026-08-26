import 'package:flutter/material.dart';

extension AppNavigation on BuildContext {
  Future<void> push(Widget page) {
    return Navigator.push(this, MaterialPageRoute(builder: (_) => page));
  }

  Future<void> pushReplacement(Widget page) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<void> pushAndRemoveAll(Widget page) {
    return Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  void pop<T>([T? result]) {
    if (Navigator.canPop(this)) {
      Navigator.pop(this, result);
    }
  }
}
