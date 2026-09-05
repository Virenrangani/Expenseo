import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant/gap/app_gap.dart';
import '../constant/text_style/app_text_style.dart';
import '../extension/localization_extension.dart';
import '../localization/locale_cubit.dart';
import '../navigation/app_navigation.dart';

void appLanguagePicker(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.l10n.selectLanguage, style: AppTextStyles.h4()),
          AppGap.g24,
          ListTile(
            title: Text(context.l10n.english),
            leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
            onTap: () {
              context.read<LocaleCubit>().changeLocale('en');
              context.pop(context);
            },
          ),
          ListTile(
            title: Text(context.l10n.arabic),
            leading: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
            onTap: () {
              context.read<LocaleCubit>().changeLocale('ar');
              context.pop(context);
            },
          ),
          ListTile(
            title: Text(context.l10n.hindi),
            leading: const Text('🇮🇳', style: TextStyle(fontSize: 24)),
            onTap: () {
              context.read<LocaleCubit>().changeLocale('hi');
              context.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
