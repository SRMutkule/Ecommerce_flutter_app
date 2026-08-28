import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/address_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../theme/app_colors.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String payment = 'UPI';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final addressProvider = context.watch<AddressProvider>();
    final address = addressProvider.selectedAddress;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),

      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // =====================================================
          // DELIVERY ADDRESS
          // =====================================================

          const _Step(
            number: '1',
            title: 'Delivery Address',
          ),

          const SizedBox(height: 10),

          if (address == null)
            _buildNoAddress(context)
          else
            _buildAddressCard(
              context,
              address,
            ),

          const SizedBox(height: 24),

          // =====================================================
          // PAYMENT
          // =====================================================

          const _Step(
            number: '2',
            title: 'Payment Method',
          ),

          const SizedBox(height: 10),

          RadioGroup<String>(
            groupValue: payment,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  payment = value;
                });
              }
            },
            child: Column(
              children: [
                ...[
                  'UPI',
                  'Credit Card',
                  'Debit Card',
                  'Net Banking',
                  'Cash on Delivery',
                ].map(
                      (method) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _PaymentMethodTile(
                      method: method,
                      subtitle: _paymentSubtitle(method),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // =====================================================
          // ORDER SUMMARY
          // =====================================================

          const _Step(
            number: '3',
            title: 'Order Summary',
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: _box(),
            child: Column(
              children: [
                _SummaryRow(
                  'Items',
                  '${cart.itemCount}',
                ),

                _SummaryRow(
                  'Subtotal',
                  '₹${cart.subtotal.toStringAsFixed(0)}',
                ),

                _SummaryRow(
                  'Delivery',
                  cart.delivery == 0
                      ? 'FREE'
                      : '₹${cart.delivery.toStringAsFixed(0)}',
                ),

                const Divider(height: 20),

                _SummaryRow(
                  'Total',
                  '₹${cart.total.toStringAsFixed(0)}',
                  bold: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // =====================================================
          // PLACE ORDER
          // =====================================================

          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: address == null
                  ? null
                  : () {
                final cart = context.read<CartProvider>();

                if (cart.items.isEmpty) {
                  return;
                }

                context.read<OrderProvider>().addOrder(
                  items: cart.items,
                  total: cart.total,
                );

                cart.clear();

                _showSuccess(context);
              },
              child: const Text(
                'PLACE ORDER',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // =============================================================
  // ADDRESS CARD
  // =============================================================

  Widget _buildAddressCard(
      BuildContext context,
      dynamic address,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  address.type == 'Work'
                      ? Icons.work_outline
                      : Icons.home_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  address.type,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  _showAddressSelector(context);
                },
                child: const Text('CHANGE'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            address.name,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            address.phone,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            address.fullAddress,
            style: const TextStyle(
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // NO ADDRESS
  // =============================================================

  Widget _buildNoAddress(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _box(),
      child: Column(
        children: [
          const Icon(
            Icons.location_off_outlined,
            size: 42,
            color: AppColors.muted,
          ),

          const SizedBox(height: 10),

          const Text(
            'No delivery address',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Please add a delivery address before placing your order.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.muted,
            ),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              _showAddressSelector(context);
            },
            child: const Text('ADD ADDRESS'),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // PAYMENT METHODS
  // =============================================================

  String? _paymentSubtitle(String method) {
    switch (method) {
      case 'UPI':
        return 'Google Pay, PhonePe, Paytm & more';

      case 'Credit Card':
        return 'Visa, Mastercard, RuPay';

      case 'Debit Card':
        return 'Visa, Mastercard, RuPay';

      case 'Net Banking':
        return 'All major banks supported';

      case 'Cash on Delivery':
        return 'Pay when your order arrives';

      default:
        return null;
    }
  }

  // =============================================================
  // ADDRESS SELECTOR
  // =============================================================

  void _showAddressSelector(BuildContext context) {
    final provider = context.read<AddressProvider>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              5,
              16,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Delivery Address',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 16),

                RadioGroup<String>(
                  groupValue: provider.selectedAddress?.id,
                  onChanged: (value) {
                    if (value != null) {
                      provider.selectAddress(value);
                      Navigator.pop(sheetContext);
                    }
                  },
                  child: Column(
                    children: provider.addresses.map(
                          (address) => RadioListTile<String>(
                        value: address.id,
                        title: Text(
                          address.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Text(
                          address.fullAddress,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        activeColor: AppColors.primary,
                      ),
                    ).toList(),
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(sheetContext);

                      // Navigate to your AddressesScreen.
                      //
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const AddressesScreen(),
                      //   ),
                      // );
                    },
                    icon: const Icon(
                      Icons.add_location_alt_outlined,
                    ),
                    label: const Text(
                      'Add New Address',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =============================================================
  // SUCCESS
  // =============================================================

  void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Order Placed 🎉',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),

          content: Text(
            'Your order has been placed successfully using $payment.',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pop(context);
              },
              child: const Text('DONE'),
            ),
          ],
        );
      },
    );
  }

  // =============================================================
  // BOX
  // =============================================================

  BoxDecoration _box() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: AppColors.border,
      ),
    );
  }
}

// ===============================================================
// STEP
// ===============================================================

class _Step extends StatelessWidget {
  final String number;
  final String title;

  const _Step({
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          child: Text(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        const SizedBox(width: 9),

        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

// ===============================================================
// SUMMARY ROW
// ===============================================================

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _SummaryRow(
      this.label,
      this.value, {
        this.bold = false,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight:
                bold ? FontWeight.w900 : FontWeight.w500,
              ),
            ),
          ),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight:
                bold ? FontWeight.w900 : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final String method;
  final String? subtitle;

  const _PaymentMethodTile({
    required this.method,
    this.subtitle,
  });

  IconData _getIcon() {
    switch (method) {
      case 'UPI':
        return Icons.account_balance_wallet_outlined;

      case 'Credit Card':
        return Icons.credit_card_outlined;

      case 'Debit Card':
        return Icons.payment_outlined;

      case 'Net Banking':
        return Icons.account_balance_outlined;

      case 'Cash on Delivery':
        return Icons.local_shipping_outlined;

      default:
        return Icons.payment_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      value: method,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),

      tileColor: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
          color: AppColors.border,
        ),
      ),

      secondary: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          _getIcon(),
          color: AppColors.primary,
          size: 21,
        ),
      ),

      title: Text(
        method,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 14,
        ),
      ),

      subtitle: subtitle == null
          ? null
          : Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          subtitle!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}