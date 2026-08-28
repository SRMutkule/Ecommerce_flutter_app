import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  double get subtotal => _items.fold(0, (sum, item) => sum + item.total);
  double get savings => _items.fold(
        0,
        (sum, item) => sum + (item.product.originalPrice - item.product.price) * item.quantity,
      );
  double get delivery => subtotal >= 999 || subtotal == 0 ? 0 : 49;
  double get total => subtotal + delivery;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  void add(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void increment(String id) {
    final item = _items.firstWhere((item) => item.product.id == id);
    item.quantity++;
    notifyListeners();
  }

  void decrement(String id) {
    final index = _items.indexWhere((item) => item.product.id == id);
    if (index == -1) return;
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void remove(String id) {
    _items.removeWhere((item) => item.product.id == id);
    notifyListeners();
  }
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
