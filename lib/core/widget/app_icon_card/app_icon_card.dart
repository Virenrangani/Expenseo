import 'package:flutter/material.dart';

import '../../constant/border_radius/app_border_radius.dart';
import '../../constant/colour/app_color.dart';
import '../../constant/gap/app_gap.dart';
import '../../constant/padding/app_padding.dart';
import '../../constant/text_style/app_text_style.dart';

class AppIconCard extends StatefulWidget {
  const AppIconCard({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  @override
  State<AppIconCard> createState() => _AppIconCardState();
}

class _AppIconCardState extends State<AppIconCard> {

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: GestureDetector(

        onTapDown: (_) {
          setState(() {
            isPressed = true;
          });
        },

        onTapUp: (_) {
          setState(() {
            isPressed = false;
          });
        },

        onTapCancel: () {
          setState(() {
            isPressed = false;
          });
        },

        onTap: widget.onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),

          transform: Matrix4.identity()
            ..scaleAdjoint(isPressed ? 0.96 : 1.0),

          padding: AppPadding.edgeAll12,
          decoration: BoxDecoration(
            color: isPressed
                ? AppColor.primary.withAlpha(18)
                : AppColor.background,
            borderRadius: AppBorderRadius.cir16,
            border: Border.all(
              color: isPressed
                  ? AppColor.primary.withAlpha(80)
                  : AppColor.divider.withAlpha(40),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: isPressed ? 4 : 10,
                offset: Offset(0, isPressed ? 2 : 5,),
                color: Colors.black.withAlpha(
                  isPressed ? 12 : 25,
                ),
              ),
            ],
          ),

          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPressed
                      ? AppColor.primary.withAlpha(40)
                      : AppColor.primary.withAlpha(22),
                ),

                child: Icon(
                  widget.icon,
                  size: 24,color: AppColor.primary,
                ),
              ),

              AppGap.g8,

              Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 180),
                  style: AppTextStyles.captionMedium(
                    color: isPressed
                        ? AppColor.primary
                        : AppColor.textPrimary,
                  ),

                  child: Text(
                    widget.text,
                    maxLines: 1,overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              AnimatedSlide(
                duration: const Duration(milliseconds: 180),
                offset: isPressed
                    ? const Offset(0.15, 0)
                    : Offset.zero,
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14, color: AppColor.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}