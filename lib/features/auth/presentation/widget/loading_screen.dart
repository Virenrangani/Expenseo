import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/image/app_image.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.background,

      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            ScaleTransition(
              scale: scaleAnimation,

              child: Image.asset(
                AppImage.expenseoLogo,

                width: 240,
                height: 240,
              ),
            ),

          ],
        ),
      ),
    );
  }
}