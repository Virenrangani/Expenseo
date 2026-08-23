import 'package:expenseo/core/widget/snack_bar/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/border_radius/app_border_radius.dart';
import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/padding/app_padding.dart';
import '../../../../core/constant/text_style/app_text_style.dart';
import '../../../../core/extension/localization_extension.dart';
import '../../../../core/widget/elevated_button/app_elevated_button.dart';
import '../../../../core/widget/text_field/app_text_field.dart';
import '../../domain/entity/user.dart';
import '../cubit/split_cubit.dart';
import '../cubit/split_state.dart';
import '../widget/group_member_tile.dart';

class SplitGroupBottomSheet extends StatefulWidget {
  const SplitGroupBottomSheet({super.key});

  @override
  State<SplitGroupBottomSheet> createState() => _SplitGroupBottomSheetState();
}

class _SplitGroupBottomSheetState extends State<SplitGroupBottomSheet> {
  final groupNameController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<User> _members = [];

  @override
  void dispose() {
    groupNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 16,
        left: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: BlocConsumer<SplitCubit, SplitState>(
        listener: (context, state) {
          if (state is SplitSuccess) {
            Navigator.pop(context);
            context.read<SplitCubit>().getGroups();
            CustomSnacksBar.showSuccess(context, state.message);
          }
          if (state is SplitError) {
            CustomSnacksBar.showError(context, state.message);
          }
          if (state is UserSearchResult) {
            setState(() {
              final alreadyExists = _members.any(
                (user) => user.uid == state.user.uid,
              );

              if (!alreadyExists) {
                _members.add(state.user);
              }
              emailController.clear();
            });
          }
          if (state is UserSearchNotFound) {
            CustomSnacksBar.showInfo(context, context.l10n.userNotFound);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppGap.g16,
                Text(context.l10n.groupName, style: AppTextStyles.bodySmall()),
                AppGap.g8,
                AppFormField(
                  controller: groupNameController,
                  hintText: context.l10n.groupHint,
                  validator: (v) =>
                      v!.trim().isEmpty ? context.l10n.enterGroupName : null,
                ),

                AppGap.g24,

                Text(context.l10n.addMember, style: AppTextStyles.bodySmall()),
                AppGap.g8,
                Row(
                  children: [
                    Expanded(
                      child: AppFormField(
                        controller: emailController,
                        hintText: context.l10n.emailHint,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    AppGap.g8,
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        final email = emailController.text.trim();
                        if (email.isEmpty) return;
                        context.read<SplitCubit>().searchUser(email, context);
                      },
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: AppBorderRadius.cir12,
                        ),
                        child: state is UserSearchLoading
                            ? const Padding(
                                padding: AppPadding.edgeAll12,
                                child: CircularProgressIndicator(
                                  color: AppColor.background,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(
                                Icons.search,
                                size: 32,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ],
                ),

                if (_members.isNotEmpty) ...[
                  AppGap.g16,
                  Text(
                    '${context.l10n.members} (${_members.length})',
                    style: AppTextStyles.captionMedium(),
                  ),
                  AppGap.g8,

                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _members.length,
                      itemBuilder: (context, index) {
                        final member = _members[index];
                        return GroupMemberTile(
                          name: member.name,
                          onRemove: () {
                            setState(() {
                              _members.removeWhere(
                                (user) => user.uid == member.uid,
                              );
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],

                AppGap.g24,

                AppElevatedButton(
                  text: context.l10n.createGroup,
                  isLoading: state is SplitLoading,
                  isEnabled: true,
                  onPressed: _onCreateGroup,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onCreateGroup() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_members.isEmpty) {
      CustomSnacksBar.showInfo(context, context.l10n.addAtLeastOneMember);
      return;
    }

    context.read<SplitCubit>().createGroup(
      context: context,
      name: groupNameController.text.trim(),
      memberEmails: _members.map((user) => user.email).toList(),
    );
  }
}
