import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/price_view.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: Text('My Cart (${cart.itemCount})')),
      body: cart.items.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 70, color: AppColors.muted),
                  SizedBox(height: 12),
                  Text('Your cart is empty', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  SizedBox(height: 5),
                  Text('Add something you love.', style: TextStyle(color: AppColors.muted)),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...cart.items.map(
                  (item) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(item.product.imageUrl, width: 92, height: 92, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 8),
                              PriceView(price: item.product.price, originalPrice: item.product.originalPrice),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(onPressed: () => cart.decrement(item.product.id), icon: const Icon(Icons.remove_circle_outline)),
                                  Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.w800)),
                                  IconButton(onPressed: () => cart.increment(item.product.id), icon: const Icon(Icons.add_circle_outline)),
                                  const Spacer(),
                                  IconButton(onPressed: () => cart.remove(item.product.id), icon: const Icon(Icons.delete_outline)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text('Price Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900))),
                      const SizedBox(height: 14),
                      _Row('Price', '₹${cart.subtotal.toStringAsFixed(0)}'),
                      _Row('Savings', '- ₹${cart.savings.toStringAsFixed(0)}', color: AppColors.success),
                      _Row('Delivery', cart.delivery == 0 ? 'FREE' : '₹${cart.delivery.toStringAsFixed(0)}'),
                      const Divider(height: 24),
                      _Row('Total', '₹${cart.total.toStringAsFixed(0)}', bold: true),
                      if (cart.savings > 0) ...[
                        const SizedBox(height: 10),
                        Align(alignment: Alignment.centerLeft, child: Text('You save ₹${cart.savings.toStringAsFixed(0)} on this order 🎉', style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w700))),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen())),
                  child: const Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Text('PROCEED TO CHECKOUT')),
                ),
              ],
            ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  final bool bold;

  const _Row(this.label, this.value, {this.color, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: color ?? AppColors.muted, fontWeight: bold ? FontWeight.w800 : null)),
          Text(value, style: TextStyle(color: color, fontWeight: bold ? FontWeight.w900 : FontWeight.w600)),
        ],
      ),
    );
  }
}
