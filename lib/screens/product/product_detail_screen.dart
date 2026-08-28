import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/price_view.dart';
import '../../widgets/rating_badge.dart';
import '../cart/cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final wished = context.watch<WishlistProvider>().contains(product.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            onPressed: () => context.read<WishlistProvider>().toggle(product),
            icon: Icon(wished ? Icons.favorite : Icons.favorite_border),
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(product.imageUrl, fit: BoxFit.cover),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text('F-Assured', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800)),
                const SizedBox(height: 7),
                Text(product.name, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
                const SizedBox(height: 10),
                RatingBadge(rating: product.rating, reviews: product.reviews),
                const SizedBox(height: 14),
                PriceView(price: product.price, originalPrice: product.originalPrice),
                const SizedBox(height: 20),
                const Text('Highlights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                ...product.highlights.map((h) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, size: 18, color: AppColors.success),
                          const SizedBox(width: 8),
                          Expanded(child: Text(h)),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                const Text('Specifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                ...product.specifications.entries.map((e) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
                      child: Row(
                        children: [
                          SizedBox(width: 120, child: Text(e.key, style: const TextStyle(color: AppColors.muted))),
                          Expanded(child: Text(e.value, style: const TextStyle(fontWeight: FontWeight.w600))),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                const Text('Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(
                    children: [
                      Text(product.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
                      const Icon(Icons.star, color: AppColors.accent),
                      const SizedBox(height: 5),
                      Text('${product.reviews} ratings & reviews', style: const TextStyle(color: AppColors.muted)),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomSheet: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurRadius: 14, color: Color(0x22000000))]),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.read<CartProvider>().add(product);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
                  },
                  child: const Text('ADD TO CART'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    context.read<CartProvider>().add(product);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                  },
                  child: const Text('BUY NOW'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
