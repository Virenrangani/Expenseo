import 'package:flutter/material.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../domain/entity/split_entity.dart';

class SplitTypeSelector extends StatelessWidget {
  final SplitType selected;
  final ValueChanged<SplitType> onChanged;

  const SplitTypeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final types = SplitType.values
        .where((t) => t != SplitType.settlement)
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: AppBorderRadius.cir16,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: types.map((type) {
          final isSelected = selected == type;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: AppBorderRadius.cir12,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  _label(type),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.captionBold(
                    color: isSelected ? AppColor.primary : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _label(SplitType type) {
    switch (type) {
      case SplitType.equal:
        return 'Equal';
      case SplitType.unequal:
        return 'Unequal';
      case SplitType.percentage:
        return 'Percent';
      default:
        return '';
    }
  }
}
