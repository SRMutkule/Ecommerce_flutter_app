import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import '../../providers/order_provider.dart';
import '../../theme/app_colors.dart';
import 'order_tracking_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: false,
      ),
      body: orders.isEmpty
          ? _buildEmptyOrders()
          : ListView(
        padding: const EdgeInsets.fromLTRB(
          16,
          18,
          16,
          24,
        ),
        children: [
          _buildHeader(orders.length),
          const SizedBox(height: 16),

          ...orders.map(
                (order) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _OrderCard(
                order: order,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderTrackingScreen(
                        order: order,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int orderCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Your Orders',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          '$orderCount orders',
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyOrders() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'No Orders Yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Looks like you haven’t placed an order yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback onTap;

  const _OrderCard({
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = order['items'] as List<CartItem>;

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final delivered = order['status'] == 'Delivered';
    final firstItem = items.first;
    final remainingItems = items.length - 1;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Column(
            children: [
              _buildOrderTop(),
              const SizedBox(height: 15),
              const Divider(height: 1),
              const SizedBox(height: 15),
              _buildProduct(
                firstItem,
                remainingItems,
              ),
              const SizedBox(height: 15),
              _buildBottom(delivered),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderTop() {
    final statusColor =
        order['statusColor'] as Color? ?? AppColors.primary;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order ID',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                order['id']?.toString() ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                order['date']?.toString() ?? '',
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            order['status']?.toString() ?? 'Placed',
            style: TextStyle(
              color: statusColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProduct(
      CartItem item,
      int remainingItems,
      ) {
    return Row(
      children: [
        Container(
          height: 82,
          width: 82,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Image.network(
            item.product.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return const Icon(
                Icons.shopping_bag_outlined,
                size: 38,
                color: AppColors.primary,
              );
            },
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Qty: ${item.quantity}',
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                '₹${item.total.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (remainingItems > 0) ...[
                const SizedBox(height: 5),
                Text(
                  '+ $remainingItems more '
                      '${remainingItems == 1 ? 'item' : 'items'}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottom(bool delivered) {
    return Row(
      children: [
        Icon(
          delivered
              ? Icons.check_circle_outline
              : Icons.local_shipping_outlined,
          size: 18,
          color: delivered
              ? Colors.green
              : AppColors.primary,
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            delivered
                ? 'Delivered successfully'
                : 'Your package is on the way',
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 12,
            ),
          ),
        ),
        const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: AppColors.muted,
        ),
      ],
    );
  }
}