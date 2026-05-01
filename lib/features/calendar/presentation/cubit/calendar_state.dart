
import 'package:flutter/material.dart';

abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final int year;
  final int month;
  final int day;
  final int index;

  CalendarLoaded({
    required this.year,
    required this.month,
    required this.index,
    required this.day});

  int get daysInMonth => DateUtils.getDaysInMonth(year, month + 1);

  int get prevMonthIndex => month == 0 ? 11 : month - 1;
  int get prevYear => month == 0 ? year - 1 : year;
  int get daysInPrevMonth =>
      DateUtils.getDaysInMonth(prevYear, prevMonthIndex + 1);

  int get nextMonthIndex => month == 11 ? 0 : month + 1;
  int get nextYear => month == 11 ? year + 1 : year;

  CalendarLoaded copyWith({
    int? year,
    int? month,
    int? index,
    int? day
  }) {
    return CalendarLoaded(
      year: year ?? this.year,
      month: month ?? this.month,
      index: index ?? this.index,
      day: day ?? this.day,
    );
  }
}

class CalendarError extends CalendarState {
  final String message;
  CalendarError(this.message);
}
