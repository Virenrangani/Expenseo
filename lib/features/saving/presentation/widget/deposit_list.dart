import 'package:expenseo/core/constant/border_radius/app_border_radius.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../domain/entity/deposit.dart';
import 'deposit_tile.dart';

class DepositList extends StatefulWidget {
  final List<Deposit> deposits;
  final bool showDepositTitle;
  final double sheetSize;
  final ValueChanged<bool> onTitleVisibilityChanged;

  const DepositList({
    super.key,
    required this.deposits,
    required this.showDepositTitle,
    required this.sheetSize,
    required this.onTitleVisibilityChanged,
  });

  @override
  State<DepositList> createState() => _DepositListState();
}

class _DepositListState extends State<DepositList> {
  double scrollOffset = 0;
  late bool showDepositTitlee = widget.showDepositTitle;
  late double sheetSizee = widget.sheetSize;

  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    sheetController.addListener(() {
      setState(() {
        sheetSizee = sheetController.size;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: sheetController,
      initialChildSize: 0.55,
      minChildSize: 0.55,
      maxChildSize: 0.86,
      snap: true,
      snapSizes: const [0.55, 0.86],
      builder: (context, scrollController) {
        scrollController.addListener(() {
          if (scrollController.offset > 40 && !showDepositTitlee) {
            setState(() {
              showDepositTitlee = true;
            });
            widget.onTitleVisibilityChanged(true);
          } else if (scrollController.offset <= 40 && showDepositTitlee) {
            setState(() {
              showDepositTitlee = false;
            });
            widget.onTitleVisibilityChanged(false);
          }

          setState(() {
            scrollOffset = scrollController.offset;
          });
        });
        return Container(
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: AppBorderRadius.cir24,
          ),

          child: Column(
            children: [
              AppGap.g12,

              Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              AppGap.g12,

              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: widget.deposits.length + 1,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: AppPadding.edgeSymmetricHori16,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deposit History',
                              style: AppTextStyles.captionBold(),
                            ),

                            AppGap.g12,
                          ],
                        ),
                      );
                    }

                    final deposit = widget.deposits[index - 1];
                    return DepositTile(deposit: deposit);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
