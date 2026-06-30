import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';

class GoalEmptyState extends StatefulWidget {
  const GoalEmptyState({super.key});

  @override
  State<GoalEmptyState> createState() => _GoalEmptyStateState();
}

class _GoalEmptyStateState extends State<GoalEmptyState>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppPadding.edgeAll16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 240,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final floatY = math.sin(_controller.value * math.pi) * 15;
                  final floatYInverse =
                      math.cos(_controller.value * math.pi) * 10;

                  return Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primary.withAlpha(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.primary.withAlpha(30),
                              blurRadius: 40 + (_controller.value * 20),
                              spreadRadius: 10 + (_controller.value * 10),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        right: 40,
                        top: 20 + floatYInverse,
                        child: _buildFloatingIcon(
                          Icons.monetization_on,
                          28,
                          Colors.amber,
                        ),
                      ),

                      Positioned(
                        left: 30,
                        bottom: 30 - floatYInverse,
                        child: _buildFloatingIcon(
                          Icons.auto_awesome,
                          24,
                          Colors.orangeAccent,
                        ),
                      ),

                      // Main Flying Rocket / Goal Icon
                      Transform.translate(
                        offset: Offset(0, -floatY),
                        child: Transform.rotate(
                          angle: _controller.value * 0.05,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColor.background,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.textPrimary.withAlpha(10),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.rocket_launch_rounded,
                                size: 48,
                                color: AppColor.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            AppGap.g32,

            Text(
              "Your savings journey is waiting on the launchpad.\nSet your first goal and let's take off!",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall(
                color: Colors.grey.shade600,
              ).copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon, double size, Color color) {
    return Transform.rotate(
      angle: math.pi / 12,
      child: Icon(icon, size: size, color: color.withAlpha(200)),
    );
  }
}
