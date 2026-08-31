import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calendar_state.dart';


class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial()){
    init();
  }

  void init() {
    try {
      final now = DateTime.now();
      const baseIndex = 96;
      final initialIndex = baseIndex + (now.month - 1);
      emit(CalendarLoaded(
        year: now.year, month: now.month-1 , index: initialIndex, day: now.day,
      ));
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }

  void selectYear(int year) {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    final monthDelta = (year - s.year) * 12;
    final nextIndex = s.index + monthDelta;
    final nextDay = s.day.clamp(1, DateUtils.getDaysInMonth(year, s.month + 1));

    emit(s.copyWith(year: year, index: nextIndex, day: nextDay));
  }

  void selectMonth(int monthIndex) {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    final monthOffset = monthIndex - s.index;
    final monthValue = s.month + monthOffset;
    final newYear = s.year + (monthValue ~/ 12);
    final newMonth = ((monthValue % 12) + 12) % 12;
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

    emit(CalendarLoaded(
      year: s.prevYear,
      month: s.prevMonthIndex,
      day: s.daysInPrevMonth,
      index: s.index - 1,
    ));
  }

  void goToNextMonth() {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    emit(CalendarLoaded(
      year: s.nextYear,
      month: s.nextMonthIndex,
      day: 1,
      index: s.index + 1,
    ));
  }

  void goToMonth({
    required int year,
    required int monthIndex,
    required int day,
  }) {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    final monthDiff = (year - s.year) * 12 + (monthIndex - s.month);

    emit(CalendarLoaded(
      year: year,
      month: monthIndex,
      day: day,
      index:s.index + monthDiff
    ));
  }

  /// Move calendar to today's date and update index accordingly.
  void focusToday() {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;
    final now = DateTime.now();

    final monthDiff = (now.year - s.year) * 12 + (now.month - 1 - s.month);
    final newIndex = s.index + monthDiff;

    final maxDay = DateUtils.getDaysInMonth(now.year, now.month);
    final newDay = now.day.clamp(1, maxDay);

    emit(CalendarLoaded(
      year: now.year,
      month: now.month - 1,
      day: newDay,
      index: newIndex,
    ));
  }
}
