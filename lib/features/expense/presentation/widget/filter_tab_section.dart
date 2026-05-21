import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:flutter/material.dart';

class FilterTabSection<T> extends StatelessWidget {
  final List<String> tabs;
  final List<T> values;
  final T selectedValue;
  final void Function(T value) onSelected;

  const FilterTabSection({
    super.key,
    required this.tabs,
    required this.values,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,

        separatorBuilder: (_, _) => AppGap.g8,
        itemBuilder: (context, index) {
          final value = values[index];
          final isSelected = selectedValue == value;

          return GestureDetector(
            onTap: () {
              onSelected(value);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),

              padding: AppPadding.edgeSymmetricHori16,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primary
                    : AppColor.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColor.primary : AppColor.textSecondary,
                ),
              ),

              child: Center(
                child: Text(tabs[index],
                  style: isSelected
                      ? AppTextStyles.titleSmall(color: AppColor.background)
                      : AppTextStyles.bodySmall()
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}