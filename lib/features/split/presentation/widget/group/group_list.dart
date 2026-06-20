import 'package:expenseo/features/split/presentation/widget/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colour/app_color.dart';
import '../../../../../core/constant/gap/app_gap.dart';
import '../../../../../core/constant/text_style/app_text_style.dart';
import '../../cubit/split_cubit.dart';
import '../../cubit/split_state.dart';
import 'group_card.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplitCubit, SplitState>(
      builder: (context, state) {

        if (state is SplitLoading) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }

        if (state is SplitError) {
          return Center(
            child: Text(state.message,
                style: AppTextStyles.caption(color: AppColor.error)),
          );
        }

        if (state is SplitLoaded) {
          if (state.groups.isEmpty) return const EmptyState();

          return ListView.separated(
            itemCount: state.groups.length,
            separatorBuilder: (_, _) => AppGap.g12,
            itemBuilder: (context, index) {
              return GroupCard(group: state.groups[index]);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}