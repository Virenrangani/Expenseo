import 'package:flutter/cupertino.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';

class CenterLineDesign extends StatelessWidget {
  const CenterLineDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width:  40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColor.textSecondary,
          borderRadius: AppBorderRadius.cir8,
        ),
      ),
    );
  }
}
