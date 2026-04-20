import 'package:flutter/material.dart';

import '../constant/colour/app_color.dart';

class AppTextStyles {

  // ===== HEADINGS =====
  static TextStyle h1({Color color = AppColor.textPrimary}) => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: color,
  );

  static TextStyle h2({Color color = AppColor.textPrimary}) => TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: color,
  );

  static TextStyle h3({Color color = AppColor.textPrimary}) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle h4({Color color = AppColor.textPrimary}) => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle h5({Color color = AppColor.textPrimary}) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: color,
  );

  // ===== TITLES =====
  static TextStyle titleLarge({Color color = AppColor.primary}) => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: color,
  );

  static TextStyle titleMedium({Color color = AppColor.background}) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle titleSmall({Color color = AppColor.primary}) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: color,
  );

  // ===== BODY =====
  static TextStyle bodyLarge({Color color = AppColor.textPrimary}) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle bodyMedium({Color color = AppColor.textSecondary}) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle bodySmall({Color color = AppColor.textSecondary}) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color,
  );

  // ===== DESCRIPTION =====
  static TextStyle description({Color color = AppColor.textSecondary}) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle descriptionSmall({Color color = AppColor.textSecondary}) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: color,
  );

  // ===== CAPTION =====
  static TextStyle caption({Color color = AppColor.textSecondary}) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle captionMedium({Color color = AppColor.primary}) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle captionBold({Color color = AppColor.primary}) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: color,
  );
}