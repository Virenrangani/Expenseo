import 'package:flutter_bloc/flutter_bloc.dart';
import 'calendar_state.dart';


class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial()){
    init();
  }

  void init() {
    try {
      final now = DateTime.now();
      const initialIndex = 100;
      emit(CalendarLoaded(
        year: now.year, month: now.month , index: initialIndex,
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
}
