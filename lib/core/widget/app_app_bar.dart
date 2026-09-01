import 'package:flutter/material.dart';

import '../constant/text_style/app_text_style.dart';
import 'app_back_button.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color titleColor;
  final bool centerTitle;
  final Color? backButtonIconColor;
  final Color? backButtonBorderColor;
  final Color? backButtonBackgroundColor;

  const AppAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor = Colors.transparent,
    this.titleColor = Colors.white,
    this.centerTitle = true,
    this.backButtonIconColor,
    this.backButtonBorderColor,
    this.backButtonBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: AppBackButton(
                iconColor: backButtonIconColor ?? Colors.white,
                borderColor: backButtonBorderColor ?? Colors.white30,
                backgroundColor:
                    backButtonBackgroundColor ?? Colors.transparent,
              ),
            )
          : null,
      title: Text(
        title,
        style: AppTextStyles.h4().copyWith(
          color: titleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
