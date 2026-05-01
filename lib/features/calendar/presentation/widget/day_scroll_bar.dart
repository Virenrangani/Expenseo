import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/calendar_cubit.dart';
import '../cubit/calendar_state.dart';
import 'day_card.dart';

class DayScrollBar extends StatefulWidget {
  const DayScrollBar({super.key});

  @override
  State<DayScrollBar> createState() => _DayScrollBarState();
}

class _DayScrollBarState extends State<DayScrollBar> {
  final _controller = ScrollController();
  bool _isSwitching = false;

  static const int _overflow = 7;
  static const double _cellWidth = 48;

  static const _dayNames = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isSwitching || !_controller.hasClients) return;

    final pos = _controller.position;
    final cubit = context.read<CalendarCubit>();

    if (pos.pixels <= 0) {
      _isSwitching = true;
      cubit.goToPrevMonth();
      Future.delayed(const Duration(milliseconds: 150),
              () => _isSwitching = false);
    }

    if (pos.pixels >= pos.maxScrollExtent - 2) {
      _isSwitching = true;
      cubit.goToNextMonth();
      Future.delayed(const Duration(milliseconds: 150),
              () => _isSwitching = false);
    }
  }

  void _scrollTo(int dayIndex) {
    if (!_controller.hasClients) return;

    final screenW = MediaQuery.of(context).size.width;
    final target = (_overflow + dayIndex) * _cellWidth - (screenW / 2);

    _controller.jumpTo(
      target.clamp(0, _controller.position.maxScrollExtent),
    );
  }

  String _getLetter(int y, int m, int d) {
    return _dayNames[DateTime(y, m + 1, d).weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        if (state is! CalendarLoaded) {
          return const SizedBox.shrink();
        }

        _scrollTo(state.day - 1);

        final items = _buildDays(context, state);

        return SizedBox(
          height: 60,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemExtent: _cellWidth,
            itemBuilder: (_, i) => items[i],
          ),
        );
      },
    );
  }

  List<Widget> _buildDays(BuildContext context, CalendarLoaded s) {
    final list = <Widget>[];

    for (int d = s.daysInPrevMonth - _overflow + 1;
    d <= s.daysInPrevMonth;
    d++) {
      list.add(DayCard(
        day: d,
        letter: _getLetter(s.prevYear, s.prevMonthIndex, d),
        isDim: true,
        isActive: false,
        onTap: () => context.read<CalendarCubit>().goToMonth(
          year: s.prevYear,
          monthIndex: s.prevMonthIndex,
          day: d,
        ),
      ));
    }

    for (int d = 1; d <= s.daysInMonth; d++) {
      list.add(DayCard(
        day: d,
        letter: _getLetter(s.year, s.month, d),
        isActive: d == s.day,
        isDim: false,
        onTap: () => context.read<CalendarCubit>().selectDay(d),
      ));
    }

    for (int d = 1; d <= _overflow; d++) {
      list.add(DayCard(
        day: d,
        letter: _getLetter(s.nextYear, s.nextMonthIndex, d),
        isDim: true,
        isActive: false,
        onTap: () => context.read<CalendarCubit>().goToMonth(
          year: s.nextYear,
          monthIndex: s.nextMonthIndex,
          day: d,
        ),
      ));
    }

    return list;
  }
}