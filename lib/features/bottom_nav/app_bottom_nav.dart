import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:expenseo/features/calendar/presentation/page/calendar_page.dart';
import 'package:expenseo/features/home/presentation/page/home_page.dart';
import 'package:expenseo/features/profile/presentation/page/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppBottomNav extends StatefulWidget {
  const AppBottomNav({super.key});

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  int _selectedIndex = 0;
  late final CalendarCubit _calendarCubit;

  @override
  void initState() {
    super.initState();
    _calendarCubit = CalendarCubit();
  }

  @override
  void dispose() {
    _calendarCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      BlocProvider.value(
        value: _calendarCubit,
        child: const CalendarPage(),
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColor.background,
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withAlpha(25)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: AppColor.primary,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: AppColor.primary.withAlpha(25),
              color: Colors.black,
              tabs: const [
                GButton(icon: Icons.home_outlined, text: 'Home'),
                GButton(icon: Icons.calendar_month, text: 'Calendar'),
                GButton(icon: Icons.person_outline, text: 'Profile'),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                if (index == 1) {
                  _calendarCubit.focusToday();
                }
              },

            ),
          ),
        ),
      ),
    );
  }
}
