import 'package:expenseo/core/constant/colour/app_color.dart';
import 'package:expenseo/core/constant/gap/app_gap.dart';
import 'package:expenseo/core/constant/text_style/app_text_style.dart';
import 'package:expenseo/core/extension/localization_extension.dart';
import 'package:expenseo/features/auth/presentation/page/log_in_page.dart';
import 'package:flutter/material.dart';

class LoginRequiredDialog extends StatelessWidget {
  final String featureName;

  const LoginRequiredDialog({super.key, required this.featureName});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock_outline_rounded,
              size: 64,
              color: AppColor.primary,
            ),
            AppGap.g24,
            Text(
              context.l10n.loginRequired,
              style: AppTextStyles.h4(),
              textAlign: TextAlign.center,
            ),
            AppGap.g12,
            Text(
              context.l10n.loginRequiredDescription as String,
              style: AppTextStyles.bodyMedium(),
              textAlign: TextAlign.center,
            ),
            AppGap.g32,
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(builder: (_) => const LogInPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  context.l10n.signInNow,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            AppGap.g12,
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                context.l10n.later,
                style: AppTextStyles.bodyMedium(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context, String featureName) {
    showDialog<void>(
      context: context,
      builder: (context) => LoginRequiredDialog(featureName: featureName),
    );
  }
}
