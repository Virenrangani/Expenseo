import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../storage/shared_pref/shared_pref_service.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    // We can use SharedPrefService if we add locale support there
    // For now, let's assume we want to persist it.
    final savedLanguageCode = SharedPrefService.getLanguageCode();
    if (savedLanguageCode != null) {
      emit(Locale(savedLanguageCode));
    }
  }

  void changeLocale(String languageCode) {
    SharedPrefService.setLanguageCode(languageCode);
    emit(Locale(languageCode));
  }
}
