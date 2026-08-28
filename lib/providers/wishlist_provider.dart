import 'package:flutter/foundation.dart';
import '../models/product.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get wishlist =>
      List.unmodifiable(_items);

  int get itemCount => _items.length;

  bool contains(String productId) {
    return _items.any(
          (product) => product.id == productId,
    );
  }

  void toggle(Product product) {
    final index = _items.indexWhere(
          (item) => item.id == product.id,
    );

    if (index != -1) {
      _items.removeAt(index);
    } else {
      _items.add(product);
    }

    notifyListeners();
  }

  void remove(String productId) {
    _items.removeWhere(
          (product) => product.id == productId,
    );

    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}