import 'package:curved_navigation_bar_pro/curved_navigation_bar_pro.dart';
import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/lotties/app_lottie.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/features/home/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppBottomNav extends StatefulWidget {
  const AppBottomNav({super.key});

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  int index = 0;

  final pages = [
    const HomePage(),
    const Center(child: Text('stats')),
    const Center(child: Text('profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],

      bottomNavigationBar: CurvedNavigationBarPro(
        currentIndex: index,

        onTap: (i) {
          setState(() {
            index = i;
          });
        },

        items: [
          CurvedNavigationItemPro(
            label: 'Home',

            activeWidget: Lottie.asset(
              AppLottie.home,
              width: 52,
              repeat: false,
            ),

            inactiveWidget: const Icon(Icons.home),
          ),

          CurvedNavigationItemPro(
            label: 'Graphs',

            activeWidget: Lottie.asset(
              AppLottie.graph,
              width: 34,
              repeat: false,
            ),

            inactiveWidget: const Icon(Icons.bar_chart_outlined),
          ),

          CurvedNavigationItemPro(
            label: 'Profile',

            activeWidget: Lottie.asset(
              AppLottie.profile,
              width: 34,
              repeat: false,
            ),

            inactiveWidget: const Icon(Icons.person),
          ),
        ],

        backgroundColor: AppColor.background,
        activeColor: AppColor.textPrimary,
        fabColor: AppColor.primary,
        inactiveColor: AppColor.textSecondary,
        barHeight: 84,
        fabRadius: 28,
        fabGap: 4,
        cornerRadius: 0,
        elevation: 20,
        fabSink: 16,
        animationDuration: const Duration(milliseconds: 600),
        animationCurve: Curves.easeInOutCubicEmphasized,
        activeTextStyle: AppTextStyles.captionBold(color: AppColor.textPrimary),
        inactiveTextStyle: AppTextStyles.descriptionSmall(),
      ),
    );
  }
}