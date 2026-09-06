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
  late final ScrollController _controller;
  int? _lastCenteredIndex;

  static const double _itemWidth = 148;
  static const double _itemMargin = 4;
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
  void initState() {
    super.initState();
    _controller = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<CalendarCubit>().state;
      if (state is CalendarLoaded) {
        _scrollToMonth(state.index, animate: false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollToMonth(int index, {bool animate = true}) {
    if (!_controller.hasClients) return;
    if (_lastCenteredIndex == index) return;

    _lastCenteredIndex = index;
    final screenWidth = MediaQuery.sizeOf(context).width;
    const totalItemWidth = _itemWidth + (_itemMargin * 2);

    final target =
        (index * totalItemWidth) - (screenWidth / 2) + (_itemWidth / 2);
    final clampedTarget = target.clamp(
      0.0,
      _controller.position.maxScrollExtent,
    );

    if (animate) {
      _controller.animateTo(
        clampedTarget,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    } else {
      _controller.jumpTo(clampedTarget);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarCubit, CalendarState>(
      listenWhen: (prev, curr) {
        if (prev is CalendarLoaded && curr is CalendarLoaded) {
          return prev.index != curr.index;
        }
        return curr is CalendarLoaded;
      },
      listener: (context, state) {
        if (state is CalendarLoaded) {
          _scrollToMonth(state.index);
        }
      },
      builder: (context, state) {
        if (state is! CalendarLoaded) return const SizedBox.shrink();

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
              // 40 years range: (2020 to 2060)
              itemCount: 480,
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
                    margin: const EdgeInsets.symmetric(horizontal: _itemMargin),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColor.background.withAlpha(26)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
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
