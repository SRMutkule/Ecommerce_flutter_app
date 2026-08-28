import '../models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product?> getProductById(String id);
}

// Replace this with an HTTP/API implementation when a backend is connected.
class MockProductRepository implements ProductRepository {
  final List<Product> products;

  MockProductRepository(this.products);

  @override
  Future<List<Product>> getProducts() async => products;

  @override
  Future<Product?> getProductById(String id) async {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
