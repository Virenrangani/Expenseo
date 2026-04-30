
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final int year;
  final int month;

  CalendarLoaded({ required this.year,  required this.month});

  CalendarLoaded copyWith({
    int? year,
    int? month,
  }) {
    return CalendarLoaded(
      year: year ?? this.year,
      month: month ?? this.month,
    );
  }
}

class CalendarError extends CalendarState {
  final String message;
  CalendarError(this.message);
}
