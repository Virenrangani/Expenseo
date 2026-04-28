import 'package:flutter/material.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/text_style/app_text_style.dart';

class NavigationText extends StatelessWidget {
  final String description;
  final String pageName;
  final VoidCallback onTap;

  const NavigationText({
    super.key,
    required this.description,
    required this.onTap,
    required this.pageName
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          description,
          style: AppTextStyles.bodyMedium(),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            pageName,
            style: AppTextStyles.bodyMedium(
              color: AppColor.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
