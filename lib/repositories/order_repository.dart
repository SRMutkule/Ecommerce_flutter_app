import '../models/order.dart';

class OrderRepository {
  Future<List<Order>> getOrders() async => [];
  Future<bool> cancelOrder(String orderId) async => true;
}
