import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PriceView extends StatelessWidget {
  final double price;
  final double originalPrice;

  const PriceView({
    super.key,
    required this.price,
    required this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final discount = ((1 - price / originalPrice) * 100).round();
    return Row(
      children: [
        Text(
          '₹${price.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(width: 8),
        Text(
          '₹${originalPrice.toStringAsFixed(0)}',
          style: const TextStyle(
            color: AppColors.muted,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$discount% off',
          style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
