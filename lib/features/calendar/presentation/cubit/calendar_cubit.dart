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

    emit(s.copyWith(year: year));
  }

  void selectMonth(int monthIndex) {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    emit(s.copyWith(month: monthIndex % 12, index:monthIndex));
  }

  void selectDay(int day) {
    if (state is! CalendarLoaded) return;
    final s = state as CalendarLoaded;

    emit(s.copyWith(day: day));
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
}
