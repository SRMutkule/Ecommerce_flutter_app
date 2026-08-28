import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AssuredBadge extends StatelessWidget {
  const AssuredBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'S-Assured ✓',
      style: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w800,
        fontSize: 11,
      ),
    );
  }
}
