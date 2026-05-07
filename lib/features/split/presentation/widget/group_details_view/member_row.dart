import 'package:expenseo/core/constant/padding/app_padding.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/group_entity.dart';

class MemberRow extends StatelessWidget {
  final GroupEntity group;

  const MemberRow({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: group.memberNames.length,
        itemBuilder: (context,index){

          final member = group.memberNames.entries.toList()[index];

          return Padding(
            padding: AppPadding.edgeSymmetricHori8,
            child: CircleAvatar(
              child: Text(
                member.value[0].toUpperCase(),
              ),
            ),
          );
        },
      ),
    );
  }
}