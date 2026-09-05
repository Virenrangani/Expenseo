import 'package:flutter/material.dart';

class ProfileGroupCard extends StatelessWidget {
  final List<Widget> children;

  const ProfileGroupCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              const Divider(
                height: 1,
                indent: 60,
                endIndent: 16,
                color: Color(0xFFF1F1F1),
              ),
          ],
        ],
      ),
    );
  }
}
