import 'package:expenseo/core/navigation/app_navigation.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final double iconSize;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const AppBackButton({
    super.key,
    this.onPressed,
    this.icon = Icons.arrow_back_ios_new_rounded,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.white30,
    this.iconSize = 18.0,
    this.borderRadius = 10.0,
    this.padding = const EdgeInsets.all(4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed ?? () => context.pop,
          child: Padding(
            padding: padding,
            child: Icon(icon, color: iconColor, size: iconSize),
          ),
        ),
      ),
    );
  }
}
