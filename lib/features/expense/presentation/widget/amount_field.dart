import 'package:flutter/material.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/string/app_string.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/widget/text_field/app_text_field.dart';

class AmountField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AmountField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField>
    with SingleTickerProviderStateMixin {
  final FocusNode focusNode = FocusNode();

  bool isFocused = false;
  bool hasValue = false;

  late AnimationController _controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      lowerBound: 0.95,
    );

    scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    widget.controller.addListener(_onTextChanged);

    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });

      if (focusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _onTextChanged() {
    setState(() {
      hasValue = widget.controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: AppPadding.edgeAll16,
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.cir20,
        gradient: LinearGradient(
          colors: isFocused
              ? [
            AppColor.primary.withAlpha(25),
            AppColor.background,
          ]
              : [
            AppColor.background,
            AppColor.background,
          ],
        ),
        border: Border.all(
          color: AppColor.divider.withAlpha(80),
        ),
        boxShadow: [
          if (isFocused)
            BoxShadow(
              color: AppColor.primary.withAlpha(45),
              blurRadius: 20,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: AppTextStyles.bodySmall(
              color:
              isFocused ? AppColor.primary : AppColor.textSecondary,
            ),
            child: const Text(AppString.addAmount),
          ),

          AppGap.g16,

          Row(
            children:[
              Expanded(
                child: SizedBox(
                  key: ValueKey(isFocused),
                  height: 55,
                  child: AppFormField(
                    prefixIcon: Icon(Icons.attach_money,
                      color: isFocused ? AppColor.primary : AppColor.textSecondary,),
                    controller: widget.controller,
                    focusNode: focusNode,
                    validator: widget.validator,
                    keyboardType:
                    const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: AppTextStyles.h3(
                      color: AppColor.primary,
                    ),
                    hintText: hasValue ? '' : '0.00',
                    cursorColor: AppColor.primary,
                    contentPadding:EdgeInsets.zero
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}