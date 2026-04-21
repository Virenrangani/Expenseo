import 'package:flutter/material.dart';
import '../../constant/border_radius/app_border_radius.dart';
import '../../constant/colour/app_color.dart';
import '../../constant/padding/app_padding.dart';
import '../../constant/text_style/app_text_style.dart';

class AppFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Color? borderColor;
  final bool obscureText;
  final int maxLines;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onChanged;

  const AppFormField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffix,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.onSuffixTap,
    this.onChanged,
    this.borderColor,
    this.prefix,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: "*",
      maxLines: obscureText ? 1 : maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.bodyMedium(color: AppColor.textPrimary),
        labelText: labelText,
        labelStyle:TextStyle(color: AppColor.primary),
        fillColor: AppColor.backgroundLight,
        focusColor: AppColor.background,
        filled: true,
        prefixIcon: prefixIcon != null
            ? Padding(
          padding: EdgeInsetsGeometry.only(left: 12,top: 16, bottom: 16),
          child: prefixIcon,
        )
            : null,
        suffixIcon: suffix != null
            ? InkWell(
          onTap: onSuffixTap,
          child: Padding(padding: AppPadding.edgeAll12, child: suffix),
        )
            : null,
        border: InputBorder.none,
      )
    );
  }
}
