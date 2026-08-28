class Product {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviews;
  final String description;
  final List<String> highlights;
  final Map<String, String> specifications;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.highlights,
    required this.specifications,
  });

  int get discountPercent =>
      ((1 - price / originalPrice) * 100).round();
}
