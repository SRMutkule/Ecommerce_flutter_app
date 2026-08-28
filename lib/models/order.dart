class Order {
  final String id;
  final String status;
  final DateTime date;
  final double total;

  const Order({
    required this.id,
    required this.status,
    required this.date,
    required this.total,
  });
}
