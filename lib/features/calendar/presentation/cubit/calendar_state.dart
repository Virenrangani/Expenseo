
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final int year;
  final int month;
  final int index;

  CalendarLoaded({ required this.year,  required this.month, required this.index});

  CalendarLoaded copyWith({
    int? year,
    int? month,
    int? index,
  }) {
    return CalendarLoaded(
      year: year ?? this.year,
      month: month ?? this.month,
      index: index ?? this.index,
    );
  }
}

class CalendarError extends CalendarState {
  final String message;
  CalendarError(this.message);
}
