
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final int year;

  CalendarLoaded({required this.year});

}

class CalendarError extends CalendarState {
  final String message;
  CalendarError(this.message);
}
