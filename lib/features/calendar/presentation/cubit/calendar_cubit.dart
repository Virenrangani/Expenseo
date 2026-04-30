import 'package:flutter_bloc/flutter_bloc.dart';
import 'calendar_state.dart';


class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial()){
    init();
  }

  void init() {
    try {
      final now = DateTime.now();
      emit(CalendarLoaded(
        year: now.year,
      ));
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }

  void selectYear(int year) {
    if (state is! CalendarLoaded) return;

    emit(CalendarLoaded(year: year));
  }
}
