import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class OrderProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders =>
      List.unmodifiable(_orders);

  void addOrder({
    required List<CartItem> items,
    required double total,
  }) {
    final order = {
      'id': '#SE${DateTime.now().millisecondsSinceEpoch}',
      'date': _formatDate(DateTime.now()),
      'status': 'Placed',
      'statusColor': Colors.blue,
      'items': List<CartItem>.from(items),
      'total': total,
    };

    _orders.insert(0, order);
    notifyListeners();
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day.toString().padLeft(2, '0')} '
        '${months[date.month - 1]} ${date.year}';
  }
}