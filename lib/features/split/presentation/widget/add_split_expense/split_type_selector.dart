import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../domain/entity/split_entity.dart';

class SplitTypeSelector extends StatelessWidget {
  final SplitType selected;
  final ValueChanged<SplitType> onChanged;

  const SplitTypeSelector({super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: SplitType.values.map((type) {
        final isSelected = selected == type;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.all(4),
              padding: AppPadding.edgeSymmetricVer8,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primary.withAlpha(25)
                    : AppColor.background,
                borderRadius: AppBorderRadius.cir12,
                border: Border.all(
                  color: isSelected ? AppColor.primary : AppColor.divider,
                  width: isSelected ? 1.5 : 0.5,
                ),
              ),
              child: Text(
                _label(type),
                textAlign: TextAlign.center,
                style: AppTextStyles.captionMedium(
                  color: isSelected
                      ? AppColor.secondary
                      : AppColor.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _label(SplitType type) {
    switch (type) {
      case SplitType.equal:      return 'Equal';
      case SplitType.unequal:    return 'Unequal';
      case SplitType.percentage: return 'Percent';
    }
  }
}