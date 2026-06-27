import 'package:expenseo/features/split/domain/entity/group_entity.dart';
import 'package:expenseo/features/split/presentation/widget/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
        if (state is SplitInitial || state is SplitLoading) {
          return _loadingGroups();
        }

        if (state is SplitError) {
          return Center(
            child: Text(
              state.message,
              style: AppTextStyles.caption(color: AppColor.error),
            ),
          );
        }

        if (state is SplitLoaded) {
          if (state.groups.isEmpty) return const EmptyState();

          return ListView.separated(
            padding: EdgeInsets.zero,

            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

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

  Widget _loadingGroups() {
    return Skeletonizer(
      child: ListView.separated(
        padding: EdgeInsets.zero,

        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

        itemCount: 2,
        separatorBuilder: (_, _) => AppGap.g12,
        itemBuilder: (context, index) {
          return GroupCard(
            group: GroupEntity(
              id: 'loading_$index',
              name: 'Loading Group Name Here',
              createdBy: '',
              members: const ['1', '2', '3'],
              memberNames: const {
                '1': 'Member One',
                '2': 'Member Two',
                '3': 'Member Three',
              },
              createdAt: DateTime.now(),
            ),
          );
        },
      ),
    );
  }
}
