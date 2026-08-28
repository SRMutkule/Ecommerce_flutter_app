import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Mobiles',
      'icon': Icons.phone_android,
      'description': 'Smartphones & accessories',
    },
    {
      'name': 'Fashion',
      'icon': Icons.checkroom,
      'description': 'Clothing & accessories',
    },
    {
      'name': 'Audio',
      'icon': Icons.headphones,
      'description': 'Headphones & speakers',
    },
    {
      'name': 'Watches',
      'icon': Icons.watch,
      'description': 'Smart & classic watches',
    },
    {
      'name': 'Bags',
      'icon': Icons.backpack,
      'description': 'Backpacks & travel bags',
    },
    {
      'name': 'Shoes',
      'icon': Icons.directions_run,
      'description': 'Sports & casual shoes',
    },
    {
      'name': 'Electronics',
      'icon': Icons.devices,
      'description': 'Gadgets & electronics',
    },
    {
      'name': 'Beauty',
      'icon': Icons.spa,
      'description': 'Beauty & personal care',
    },
    {
      'name': 'Home',
      'icon': Icons.home_outlined,
      'description': 'Home & kitchen',
    },
    {
      'name': 'Gaming',
      'icon': Icons.sports_esports,
      'description': 'Gaming accessories',
    },
    {
      'name': 'Books',
      'icon': Icons.menu_book,
      'description': 'Books & education',
    },
    {
      'name': 'Sports',
      'icon': Icons.sports_cricket,
      'description': 'Sports & fitness',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // HEADER
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  10,
                  16,
                  20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore Categories',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Find everything you need in one place.',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // SEARCH
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  20,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.border,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: AppColors.muted,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Search categories',
                        style: TextStyle(
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // CATEGORY GRID
            SliverLayoutBuilder(
              builder: (context, constraints) {
                const horizontalPadding = 16.0;
                const spacing = 12.0;
                const minCardWidth = 160.0;
                const minCardHeight = 155.0;

                final availableWidth =
                    constraints.crossAxisExtent -
                        (horizontalPadding * 2);

                int columns =
                (availableWidth /
                    (minCardWidth + spacing))
                    .floor();

                columns = columns.clamp(2, 5);

                final totalSpacing =
                    spacing * (columns - 1);

                final cardWidth =
                    (availableWidth - totalSpacing) /
                        columns;

                final calculatedHeight =
                    cardWidth * 0.85;

                final cardHeight = calculatedHeight
                    .clamp(
                  minCardHeight,
                  double.infinity,
                )
                    .toDouble();

                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    horizontalPadding,
                    0,
                    horizontalPadding,
                    24,
                  ),
                  sliver: SliverGrid.builder(
                    itemCount: categories.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      mainAxisExtent: cardHeight,
                    ),
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return _CategoryCard(
                        name: category['name'],
                        icon: category['icon'],
                        description: category['description'],
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(
                                '${category['name']} selected',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final String description;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.name,
    required this.icon,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor:
              AppColors.primary.withValues(alpha: .10),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 26,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}