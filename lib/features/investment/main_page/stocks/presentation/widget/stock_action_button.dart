import 'package:flutter/material.dart';

class StockActionButton extends StatelessWidget {
  final IconData icon;
  final Color color, bgColor, borderColor;
  final VoidCallback onTap;

  const StockActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
          border: Border.all(color: borderColor),
        ),
        child: Icon(icon, color: color, size: 16),
      ),
    );
  }
}
