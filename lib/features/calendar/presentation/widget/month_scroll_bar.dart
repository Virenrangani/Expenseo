import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/calendar_cubit.dart';
import '../cubit/calendar_state.dart';

class MonthScrollBar extends StatefulWidget {
  const MonthScrollBar({super.key});

  @override
  State<MonthScrollBar> createState() => _MonthScrollBarState();
}

class _MonthScrollBarState extends State<MonthScrollBar> {

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    final state = context.read<CalendarCubit>().state;

    var initialIndex = 96;
    if (state is CalendarLoaded) {
      initialIndex = state.index;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;

      final offset = (initialIndex * 150) - (screenWidth / 2) + (150 / 2);

      _controller.jumpTo(offset);
    });

    _controller = ScrollController();
  }

  static const months = [
    'January', 'February', 'March', 'April',
    'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        if (state is! CalendarLoaded) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 60,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount:300,
            itemBuilder: (context, i) {
              final  month= i % 12;
              final isActive = i == state.index;

              return GestureDetector(
                onTap: () {
                  context.read<CalendarCubit>().selectMonth(i);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: isActive,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          color: AppColor.background,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(
                      width:150,
                      child: Center(
                        child: Text(
                          months[month],
                          style: TextStyle(
                            color: isActive ? AppColor.background : Colors.white60,
                            fontSize: 26,
                            fontWeight: isActive
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}