import 'package:flutter/material.dart';

import '../../../../core/enums/app_enums.dart';

class CategoryListOption {
  final IconData icon;
  final Color    bgColor;
  final Color    iconColor;

  const CategoryListOption({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });
}

const Map<ExpenseCategory, CategoryListOption> categoryListOption = {
  ExpenseCategory.food:          CategoryListOption(icon: Icons.fastfood_rounded,     bgColor: Color(0xFFFFE4E6), iconColor: Color(0xFF9F1239)),
  ExpenseCategory.shopping:      CategoryListOption(icon: Icons.shopping_bag_rounded,  bgColor: Color(0xFFFEF3C7), iconColor: Color(0xFFB45309)),
  ExpenseCategory.transport:     CategoryListOption(icon: Icons.directions_bus_rounded,bgColor: Color(0xFFEDE9FE), iconColor: Color(0xFF5B21B6)),
  ExpenseCategory.health:        CategoryListOption(icon: Icons.favorite_rounded,      bgColor: Color(0xFFFCE7F3), iconColor: Color(0xFF9D174D)),
  ExpenseCategory.entertainment: CategoryListOption(icon: Icons.movie_rounded,         bgColor: Color(0xFFDBEAFE), iconColor: Color(0xFF1E40AF)),
  ExpenseCategory.salary:        CategoryListOption(icon: Icons.work_rounded,          bgColor: Color(0xFFD1FAE5), iconColor: Color(0xFF065F46)),
  ExpenseCategory.rent:          CategoryListOption(icon: Icons.home_rounded,          bgColor: Color(0xFFF0FDF4), iconColor: Color(0xFF166534)),
  ExpenseCategory.other:         CategoryListOption(icon: Icons.more_horiz_rounded,    bgColor: Color(0xFFF1F5F9), iconColor: Color(0xFF475569)),
};