import 'package:flutter/material.dart';
import 'package:expenseo/features/home/presentation/page/home_page.dart';
import '../../core/constant/colour/app_color.dart';

class AppBottomNav extends StatefulWidget {
  const AppBottomNav({super.key});

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  int currentIndex = 0;

  final List<Widget> screens =  [
    HomePage(),
    Center(child: Text("Search")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home,color:AppColor.secondary,),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search,color:AppColor.secondary,),
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person,color:AppColor.secondary,),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

