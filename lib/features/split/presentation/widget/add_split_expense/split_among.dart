import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/features/split/domain/entity/group_entity.dart';
import 'package:expenseo/features/split/domain/entity/split_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../../../../core/widget/text_field/app_text_field.dart';

class SplitAmong extends StatefulWidget {
  final GroupEntity group;
  final SplitType splitType;
  final TextEditingController amountController;
  final Map<String, TextEditingController> splitControllers;

  const SplitAmong({
    super.key,
    required this.group,
    required this.splitType,
    required this.amountController,
    required this.splitControllers,
  });

  @override
  State<SplitAmong> createState() => _SplitAmongState();
}

class _SplitAmongState extends State<SplitAmong> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.group.members.map((uid) {
        final name = widget.group.memberNames[uid] ?? '';
        final isEqual = widget.splitType == SplitType.equal;
        final total = double.tryParse(widget.amountController.text) ?? 0;
        final share = isEqual ? total / widget.group.members.length : null;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: AppPadding.edgeAll12,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppBorderRadius.cir16,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColor.primary.withAlpha(20),
                child: Text(
                  name[0].toUpperCase(),
                  style: AppTextStyles.captionBold(),
                ),
              ),
              AppGap.g12,

              Expanded(
                child: Text(
                  name,
                  style: AppTextStyles.captionBold(color: AppColor.textPrimary),
                ),
              ),

              if (isEqual)
                Text('₹${share!.toStringAsFixed(2)}', style: AppTextStyles.h5())
              else
                SizedBox(
                  width: 90,
                  child: AppFormField(
                    controller: widget.splitControllers[uid],
                    hintText: widget.splitType == SplitType.percentage
                        ? '0%'
                        : '₹ 0',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.center,
                    fillColor: Colors.grey.shade100,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
