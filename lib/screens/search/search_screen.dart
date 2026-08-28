import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  String? category;
  double? minRating;

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().search(
          controller.text,
          category: category,
          minRating: minRating,
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              autofocus: true,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: controller.clear, icon: const Icon(Icons.close)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                FilterChip(
                    label: const Text('4★ & above'),
                    selected: minRating != null,
                    onSelected: (v) =>
                        setState(() => minRating = v ? 4 : null)),
                const SizedBox(width: 8),
                FilterChip(
                    label: const Text('Electronics'),
                    selected: category == 'Electronics',
                    onSelected: (v) =>
                        setState(() => category = v ? 'Electronics' : null)),
                const SizedBox(width: 8),
                FilterChip(
                    label: const Text('Fashion'),
                    selected: category == 'Fashion',
                    onSelected: (v) =>
                        setState(() => category = v ? 'Fashion' : null)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const horizontalPadding = 16.0;
                const spacing = 12.0;
                const minCardWidth = 160.0;

                final availableWidth =
                    constraints.maxWidth - (horizontalPadding * 2);

                int columns =
                (availableWidth / (minCardWidth + spacing)).floor();

                columns = columns.clamp(2, 5);

                final totalSpacing = spacing * (columns - 1);

                final cardWidth =
                    (availableWidth - totalSpacing) / columns;

                final cardHeight = cardWidth * 1.60;

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    horizontalPadding,
                    16,
                    horizontalPadding,
                    24,
                  ),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    mainAxisExtent: cardHeight,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: products[index],
                      showAddToCart: false,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
