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
  double get _allocatedAmount {
    if (widget.splitType == SplitType.equal) {
      return double.tryParse(widget.amountController.text) ?? 0;
    } else if (widget.splitType == SplitType.unequal) {
      return widget.splitControllers.values.fold(
        0.0,
        (sum, controller) => sum + (double.tryParse(controller.text) ?? 0),
      );
    } else if (widget.splitType == SplitType.percentage) {
      final total = double.tryParse(widget.amountController.text) ?? 0;
      final percentSum = widget.splitControllers.values.fold(
        0.0,
        (sum, controller) => sum + (double.tryParse(controller.text) ?? 0),
      );
      return (percentSum / 100) * total;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.splitType != SplitType.equal) ...[
          _buildProgressHeader(),
          AppGap.g16,
        ],

        ...widget.group.members.map((uid) {
          final name = widget.group.memberNames[uid] ?? '';
          final isEqual = widget.splitType == SplitType.equal;
          final total = double.tryParse(widget.amountController.text) ?? 0;
          final share = isEqual ? total / widget.group.members.length : null;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: AppPadding.edgeAll12,
            decoration: BoxDecoration(
              color: AppColor.background,
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
                    style: AppTextStyles.captionBold(
                      color: AppColor.textPrimary,
                    ),
                  ),
                ),
                if (isEqual)
                  Text(
                    '₹${share!.toStringAsFixed(2)}',
                    style: AppTextStyles.h5(),
                  )
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
        }),
      ],
    );
  }

  /// Builds the real-time math tracker above the list
  Widget _buildProgressHeader() {
    final total = double.tryParse(widget.amountController.text) ?? 0;
    final allocated = _allocatedAmount;
    final remaining = total - allocated;

    final isExceeded = remaining < -0.01;
    final isPerfect = remaining.abs() <= 0.01;

    final Color statusColor = isExceeded
        ? Colors.red.shade400
        : (isPerfect ? AppColor.success : AppColor.primary);

    final double progress = total > 0
        ? (allocated / total).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      padding: AppPadding.edgeAll16,
      decoration: BoxDecoration(
        color: statusColor.withAlpha(15),
        borderRadius: AppBorderRadius.cir16,
        border: Border.all(color: statusColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isExceeded
                    ? 'Amount Exceeded'
                    : (isPerfect ? 'Perfectly Split' : 'Remaining Amount'),
                style: AppTextStyles.captionBold(color: statusColor),
              ),
              Text(
                '₹${remaining.abs().toStringAsFixed(2)}',
                style: AppTextStyles.h5(color: statusColor),
              ),
            ],
          ),
          AppGap.g12,
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: statusColor.withAlpha(30),
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
          ),
        ],
      ),
    );
  }
}
