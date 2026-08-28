import 'package:flutter/material.dart';
import 'package:modern_ecommerce_app/screens/orders/orders_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/product_card.dart';

import '../cart/cart_screen.dart';
import '../categories/categories_screen.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';
import '../wishlist/wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navIndex = 0;

  final List<Widget> screens = [
    const _HomeContent(),
    CategoriesScreen(),
    const WishlistScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: navIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navIndex,
        onDestinationSelected: (index) {
          setState(() {
            navIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME CONTENT
// ============================================================

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ShopEase',
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              'Everything you love, in one place',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CartScreen(),
                    ),
                  );
                },
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                    ),
                    if (cart.itemCount > 0)
                      Positioned(
                        right: -5,
                        top: -5,
                        child: Container(
                          height: 17,
                          width: 17,
                          decoration: const BoxDecoration(
                            color: AppColors.danger,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${cart.itemCount}',
                              style: const TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ==================================================
            // SEARCH
            // ==================================================
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  10,
                  16,
                  0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SearchScreen(),
                      ),
                    );
                  },
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
                          'Search products, brands and more',
                          style: TextStyle(
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ==================================================
            // CATEGORIES
            // ==================================================

            SliverToBoxAdapter(
              child: SizedBox(
                height: 110,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    18,
                    16,
                    10,
                  ),
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _Category(
                      icon: Icons.phone_android,
                      label: 'Mobiles',
                    ),
                    _Category(
                      icon: Icons.checkroom,
                      label: 'Fashion',
                    ),
                    _Category(
                      icon: Icons.headphones,
                      label: 'Audio',
                    ),
                    _Category(
                      icon: Icons.watch,
                      label: 'Watches',
                    ),
                    _Category(
                      icon: Icons.backpack,
                      label: 'Bags',
                    ),
                  ],
                ),
              ),
            ),

            // ==================================================
            // SALE BANNER
            // ==================================================

            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(
                  16,
                  4,
                  16,
                  22,
                ),
                height: 195,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(22),
                ),
                padding: const EdgeInsets.all(24),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MEGA SALE',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Up to 60% OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Upgrade your everyday essentials.',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    Spacer(),
                    Chip(
                      label: Text('Shop Now →'),
                    ),
                  ],
                ),
              ),
            ),

            // ==================================================
            // DEAL OF THE DAY
            // ==================================================

            const SliverToBoxAdapter(
              child: _SectionTitle(
                title: 'Deal of the Day',
              ),
            ),

            // ==================================================
            // PRODUCTS
            // ==================================================

            SliverLayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.crossAxisExtent;

                int columns;

                if (width >= 1200) {
                  columns = 5;
                } else if (width >= 900) {
                  columns = 4;
                } else if (width >= 600) {
                  columns = 3;
                } else {
                  columns = 2;
                }

                const spacing = 12.0;

                final totalSpacing = spacing * (columns - 1);
                final cardWidth = (width - totalSpacing) / columns;

                final imageHeight = cardWidth / 1.15;
                const contentHeight = 150.0;
                final cardHeight = imageHeight + contentHeight;

                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    22,
                  ),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProductCard(
                          product: products[index],
                          showAddToCart: true,
                        );
                      },
                      childCount: products.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      mainAxisExtent: cardHeight,
                    ),
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

// ============================================================
// CATEGORY
// ============================================================

class _Category extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Category({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74,
      margin: const EdgeInsets.only(
        right: 12,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION TITLE
// ============================================================

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        0,
        16,
        12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Text(
            'See all',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}