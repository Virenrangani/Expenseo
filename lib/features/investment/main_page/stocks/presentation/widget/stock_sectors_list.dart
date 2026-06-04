import 'package:expenseo/features/investment/main_page/stocks/presentation/widget/sector_data.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constant/colour/app_color.dart';
import '../../../../../../core/constant/gap/app_gap.dart';
import '../../../../../../core/constant/padding/app_padding.dart';

class StockSectorsList extends StatefulWidget {
  final ValueChanged<String> onSectorSelected;

  const StockSectorsList({super.key, required this.onSectorSelected});

  @override
  State<StockSectorsList> createState() => _StockSectorsListState();
}

class _StockSectorsListState extends State<StockSectorsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: SectorData.sectors
                .map(
                  (sector) => InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      widget.onSectorSelected(sector.name);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: AppPadding.edgeAll12,
                      decoration: BoxDecoration(
                        color: AppColor.secondaryLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColor.background,
                            child: Text(
                              sector.icon,
                              style: const TextStyle(fontSize: 26),
                            ),
                          ),
                          AppGap.g8,
                          Text(sector.name),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
