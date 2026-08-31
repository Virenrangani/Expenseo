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
  int? _lastCenteredIndex;

  static const double _itemWidth = 148;
  static const double _itemSpacing = 8;

  @override
  void initState() {
    super.initState();
    final state = context.read<CalendarCubit>().state;
    var initialIndex = 96;
    if (state is CalendarLoaded) {
      initialIndex = state.index;
    }

    _controller = ScrollController();
    _lastCenteredIndex = initialIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToMonth(initialIndex);
    });
  }

  void _scrollToMonth(int index) {
    if (!_controller.hasClients) return;
    if (_lastCenteredIndex == index) return;

    final screenWidth = MediaQuery.sizeOf(context).width;
    const totalItemWidth = _itemWidth + _itemSpacing;
    final target =
        (index * totalItemWidth) - (screenWidth / 2) + (_itemWidth / 2);
    final maxScroll = _controller.position.maxScrollExtent;

    final clampedTarget = target.clamp(0.0, maxScroll);
    if ((_controller.offset - clampedTarget).abs() < 1) {
      _lastCenteredIndex = index;
      return;
    }

    _lastCenteredIndex = index;
    _controller.animateTo(
      clampedTarget,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
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

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToMonth(state.index);
        });

        return SizedBox(
          height: 74,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [0.0, 0.12, 0.88, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: ListView.builder(
              controller: _controller,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 300,
              itemBuilder: (context, i) {
                final month = i % 12;
                final isActive = i == state.index;

                return GestureDetector(
                  onTap: () {
                    context.read<CalendarCubit>().selectMonth(i);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOutCubic,
                    width: _itemWidth,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColor.background.withAlpha(26)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                          style: TextStyle(
                            color: isActive
                                ? AppColor.background
                                : Colors.white.withAlpha(180),
                            fontSize: isActive ? 24 : 20,
                            fontWeight: isActive
                                ? FontWeight.w700
                                : FontWeight.w500,
                            letterSpacing: isActive ? 0.3 : 0,
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
