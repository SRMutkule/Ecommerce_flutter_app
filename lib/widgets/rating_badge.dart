import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final int reviews;

  const RatingBadge({
    super.key,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.success,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 3),
              const Icon(Icons.star, size: 13, color: Colors.white),
            ],
          ),
        ),
        const SizedBox(width: 7),
        Text('$reviews ratings', style: const TextStyle(color: AppColors.muted, fontSize: 12)),
      ],
    );
  }
}
