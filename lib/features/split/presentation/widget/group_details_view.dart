import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:expenseo/features/split/presentation/cubit/split_state.dart';
import 'package:expenseo/features/split/presentation/widget/group_details_view/member_row.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constant/text_style/app_text_style.dart';

class GroupDetailsView extends StatelessWidget {
  final GroupDetailLoaded state;
  const GroupDetailsView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.edgeAll12,
          child: Column(
            children: [

              Text(
                state.group.name,
                style: AppTextStyles.h4(),
              ),

              AppGap.g16,
              
              MemberRow(group: state.group)

            ],
          )
        )
    );
  }
}
