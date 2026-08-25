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

    _controller = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final offset = (initialIndex * 150) - (screenWidth / 2) + (150 / 2);
      _controller.jumpTo(offset);
    });
  }

  static const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        if (state is! CalendarLoaded) return const SizedBox.shrink();

        return SizedBox(
          height: 60,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                  Colors.transparent,
                ],
                stops: [0.0, 0.1, 0.9, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 300,
              itemBuilder: (context, i) {
                final month = i % 12;
                final isActive = i == state.index;

                return GestureDetector(
                  onTap: () {
                    context.read<CalendarCubit>().selectMonth(i);
                    final screenWidth = MediaQuery.of(context).size.width;
                    final offset = (i * 150) - (screenWidth / 2) + (150 / 2);
                    _controller.animateTo(
                      offset,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: 150,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 250),
                          opacity: isActive ? 1.0 : 0.0,
                          child: Container(
                            height: 6,
                            width: 6,
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: const BoxDecoration(
                              color: AppColor.background,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                          style: TextStyle(
                            color: isActive
                                ? AppColor.background
                                : Colors.white54,
                            fontSize: isActive ? 26 : 22,
                            fontWeight: isActive
                                ? FontWeight.w700
                                : FontWeight.w500,
                            letterSpacing: isActive ? 0.5 : 0,
                          ),
                          child: Text(months[month]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
