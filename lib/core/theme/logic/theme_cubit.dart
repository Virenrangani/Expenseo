import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../storage/shared_pref/shared_pref_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  static const _keyLight = 'light';
  static const _keyDark = 'dark';

  Future<void> loadTheme() async {
    final mode = SharedPrefService.getThemeMode();
    if (mode == _keyDark) {
      emit(ThemeMode.dark);
    } else if (mode == _keyLight) {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.system);
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    emit(mode);
    final val = mode == ThemeMode.dark ? _keyDark : _keyLight;
    await SharedPrefService.setThemeMode(val);
  }

  Future<void> toggle() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setTheme(next);
  }
}
