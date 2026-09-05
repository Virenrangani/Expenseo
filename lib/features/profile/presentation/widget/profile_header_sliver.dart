import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../core/constant/colour/app_color.dart';
import '../../../../core/constant/gap/app_gap.dart';
import '../../../../core/constant/text_style/app_text_style.dart';

class ProfileHeaderSliver extends StatelessWidget {
  final String displayName;
  final String displayEmail;
  final String? profileImage;
  final bool isGuest;
  final ValueNotifier<bool> isCollapsedNotifier;

  const ProfileHeaderSliver({
    super.key,
    required this.displayName,
    required this.displayEmail,
    required this.profileImage,
    required this.isGuest,
    required this.isCollapsedNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final (headerAvatar, headerBackground) = _resolveImageProviders();

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      stretch: true,
      backgroundColor: AppColor.primary,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      title: ValueListenableBuilder<bool>(
        valueListenable: isCollapsedNotifier,
        builder: (context, isCollapsed, _) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isCollapsed ? 1.0 : 0.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 20, backgroundImage: headerAvatar),
                AppGap.g8,
                Text(
                  displayName,
                  style: AppTextStyles.h3(
                    color: Colors.white,
                  ).copyWith(fontSize: 18),
                ),
              ],
            ),
          );
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            headerBackground,
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withAlpha(150)],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    displayName,
                    style: AppTextStyles.h3(
                      color: Colors.white,
                    ).copyWith(fontSize: 28),
                  ),
                  Text(
                    displayEmail,
                    style: AppTextStyles.description(
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  (ImageProvider, Widget) _resolveImageProviders() {
    const defaultUrl = 'https://i.pravatar.cc/150?img=47';

    if (!isGuest && profileImage != null && profileImage!.isNotEmpty) {
      if (profileImage!.startsWith('data:')) {
        try {
          final bytes = base64Decode(profileImage!.split(',').last);
          return (MemoryImage(bytes), Image.memory(bytes, fit: BoxFit.cover));
        } catch (_) {}
      } else {
        return (
          NetworkImage(profileImage!),
          Image.network(profileImage!, fit: BoxFit.cover),
        );
      }
    }

    return (
      const NetworkImage(defaultUrl),
      Image.network(defaultUrl, fit: BoxFit.cover),
    );
  }
}
