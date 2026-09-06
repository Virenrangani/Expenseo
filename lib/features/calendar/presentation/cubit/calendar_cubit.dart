import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  static const int baseYear = 2020;

  CalendarCubit() : super(CalendarInitial()) {
    init();
  }

  void init() {
    try {
      final now = DateTime.now();
      final calculatedIndex = (now.year - baseYear) * 12 + (now.month - 1);

      emit(
        CalendarLoaded(
          year: now.year,
          month: now.month - 1,
          index: calculatedIndex,
          day: now.day,
        ),
      );
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }

  void selectYear(int year) {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    final targetIndex = (year - baseYear) * 12 + s.month;
    final maxDays = DateUtils.getDaysInMonth(year, s.month + 1);
    final nextDay = s.day.clamp(1, maxDays);

    emit(s.copyWith(year: year, index: targetIndex, day: nextDay));
  }

  void selectMonth(int monthIndex) {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    final newYear = baseYear + (monthIndex ~/ 12);
    final newMonth = monthIndex % 12;
    final maxDay = DateUtils.getDaysInMonth(newYear, newMonth + 1);
    final newDay = s.day.clamp(1, maxDay);

    emit(
      s.copyWith(
        year: newYear,
        month: newMonth,
        index: monthIndex,
        day: newDay,
      ),
    );
  }

  void selectDay(int day) {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    final maxDay = DateUtils.getDaysInMonth(s.year, s.month + 1);
    emit(s.copyWith(day: day.clamp(1, maxDay)));
  }

  void goToPrevMonth() {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    final prevIdx = s.index - 1;
    final newYear = baseYear + (prevIdx ~/ 12);
    final newMonth = prevIdx % 12;
    final maxDay = DateUtils.getDaysInMonth(newYear, newMonth + 1);

    emit(
      s.copyWith(
        year: newYear,
        month: newMonth,
        index: prevIdx,
        day: s.day.clamp(1, maxDay),
      ),
    );
  }

  void goToNextMonth() {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    final nextIdx = s.index + 1;
    final newYear = baseYear + (nextIdx ~/ 12);
    final newMonth = nextIdx % 12;
    final maxDay = DateUtils.getDaysInMonth(newYear, newMonth + 1);

    emit(
      s.copyWith(
        year: newYear,
        month: newMonth,
        index: nextIdx,
        day: s.day.clamp(1, maxDay),
      ),
    );
  }

  void goToMonth({
    required int year,
    required int monthIndex,
    required int day,
  }) {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    final calculatedIndex = (year - baseYear) * 12 + monthIndex;
    final maxDay = DateUtils.getDaysInMonth(year, monthIndex + 1);

    emit(
      s.copyWith(
        year: year,
        month: monthIndex,
        index: calculatedIndex,
        day: day.clamp(1, maxDay),
      ),
    );
  }

  void focusToday() {
    final now = DateTime.now();
    final calculatedIndex = (now.year - baseYear) * 12 + (now.month - 1);

    emit(
      CalendarLoaded(
        year: now.year,
        month: now.month - 1,
        day: now.day,
        index: calculatedIndex,
      ),
    );
  }
}
