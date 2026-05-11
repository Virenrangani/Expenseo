import 'package:flutter/cupertino.dart';

import '../../../../core/constant/colour/app_color.dart';

class GridDesign extends StatelessWidget {
  const GridDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.5,
      width: double.infinity,
      color: AppColor.primary,

      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 48,

        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),

        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                AppColor.background.withAlpha(16),
              ),
            ),
          );
        },
      ),
    );
  }
}
