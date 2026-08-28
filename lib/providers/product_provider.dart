import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> products = const [
    Product(
      id: '1',
      name: 'Wireless Noise Cancelling Headphones',
      category: 'Electronics',
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=900',
      price: 24999,
      originalPrice: 34990,
      rating: 4.6,
      reviews: 2341,
      description: 'Premium wireless headphones with immersive sound and active noise cancellation.',
      highlights: ['Active noise cancellation', '30-hour battery', 'Multipoint connection'],
      specifications: {'Brand': 'SoundMax', 'Warranty': '1 Year', 'Connectivity': 'Bluetooth 5.3'},
    ),
    Product(
      id: '2',
      name: 'Minimal Running Sneakers',
      category: 'Fashion',
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=900',
      price: 2999,
      originalPrice: 4999,
      rating: 4.4,
      reviews: 1288,
      description: 'Lightweight everyday running sneakers designed for comfort.',
      highlights: ['Lightweight', 'Breathable mesh', 'Cushioned sole'],
      specifications: {'Brand': 'RunPro', 'Material': 'Mesh', 'Sole': 'Rubber'},
    ),
    Product(
      id: '3',
      name: 'Smart Watch Pro',
      category: 'Electronics',
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=900',
      price: 5999,
      originalPrice: 8999,
      rating: 4.5,
      reviews: 982,
      description: 'Smart fitness watch with health tracking and notifications.',
      highlights: ['AMOLED display', '7-day battery', 'Fitness tracking'],
      specifications: {'Brand': 'TimeX', 'Display': 'AMOLED', 'Water Resistance': '5 ATM'},
    ),
    Product(
      id: '4',
      name: 'Classic Backpack',
      category: 'Accessories',
      imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=900',
      price: 1499,
      originalPrice: 2499,
      rating: 4.3,
      reviews: 756,
      description: 'Durable daily backpack with laptop compartment.',
      highlights: ['15-inch laptop sleeve', 'Water resistant', 'Multiple compartments'],
      specifications: {'Material': 'Polyester', 'Capacity': '24L', 'Warranty': '6 Months'},
    ),
    Product(
      id: '5',
      name: 'Premium Smartphone X1',
      category: 'Mobiles',
      imageUrl:
      'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=900',
      price: 28999,
      originalPrice: 34999,
      rating: 4.7,
      reviews: 3245,
      description:
      'Powerful smartphone with a vibrant display, fast processor and all-day battery.',
      highlights: [
        '6.7-inch AMOLED display',
        '5000mAh battery',
        '108MP camera',
      ],
      specifications: {
        'Brand': 'TechNova',
        'RAM': '8GB',
        'Storage': '256GB',
        'Warranty': '1 Year',
      },
    ),

    Product(
      id: '6',
      name: 'Mechanical Gaming Keyboard',
      category: 'Gaming',
      imageUrl:
      'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=900',
      price: 3499,
      originalPrice: 4999,
      rating: 4.6,
      reviews: 1842,
      description:
      'RGB mechanical gaming keyboard with responsive switches and premium build quality.',
      highlights: [
        'RGB backlight',
        'Mechanical switches',
        'Anti-ghosting',
      ],
      specifications: {
        'Brand': 'GameCore',
        'Switch': 'Blue Mechanical',
        'Connection': 'USB',
        'Warranty': '1 Year',
      },
    ),

    Product(
      id: '7',
      name: 'Portable Bluetooth Speaker',
      category: 'Audio',
      imageUrl:
      'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=900',
      price: 2199,
      originalPrice: 3299,
      rating: 4.5,
      reviews: 2678,
      description:
      'Compact Bluetooth speaker delivering powerful sound for indoor and outdoor use.',
      highlights: [
        '12-hour battery',
        'Water resistant',
        'Deep bass',
      ],
      specifications: {
        'Brand': 'SoundWave',
        'Bluetooth': '5.3',
        'Battery': '2400mAh',
        'Warranty': '1 Year',
      },
    ),

    Product(
      id: '8',
      name: 'Classic Analog Wrist Watch',
      category: 'Watches',
      imageUrl:
      'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=900',
      price: 4499,
      originalPrice: 6999,
      rating: 4.4,
      reviews: 934,
      description:
      'Elegant analog wrist watch designed for a classic and sophisticated look.',
      highlights: [
        'Stainless steel case',
        'Water resistant',
        'Premium leather strap',
      ],
      specifications: {
        'Brand': 'ChronoStyle',
        'Movement': 'Quartz',
        'Strap': 'Leather',
        'Warranty': '2 Years',
      },
    ),

    Product(
      id: '9',
      name: 'Ultrabook Laptop 14',
      category: 'Electronics',
      imageUrl:
      'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=900',
      price: 64999,
      originalPrice: 74999,
      rating: 4.8,
      reviews: 1567,
      description:
      'Slim and lightweight laptop designed for productivity, study and everyday computing.',
      highlights: [
        '14-inch Full HD display',
        '16GB RAM',
        '512GB SSD',
      ],
      specifications: {
        'Brand': 'NovaBook',
        'Processor': 'Intel Core i5',
        'RAM': '16GB',
        'Storage': '512GB SSD',
      },
    ),

    Product(
      id: '10',
      name: 'Cotton Casual T-Shirt',
      category: 'Fashion',
      imageUrl:
      'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=900',
      price: 799,
      originalPrice: 1299,
      rating: 4.3,
      reviews: 4210,
      description:
      'Comfortable premium cotton t-shirt suitable for casual everyday wear.',
      highlights: [
        '100% cotton',
        'Regular fit',
        'Machine washable',
      ],
      specifications: {
        'Brand': 'UrbanWear',
        'Material': '100% Cotton',
        'Fit': 'Regular',
        'Sleeve': 'Half Sleeve',
      },
    ),

    Product(
      id: '11',
      name: 'Modern Travel Duffel Bag',
      category: 'Bags',
      imageUrl:
      'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=900',
      price: 1899,
      originalPrice: 2999,
      rating: 4.5,
      reviews: 1123,
      description:
      'Spacious travel duffel bag with multiple compartments for short trips and gym use.',
      highlights: [
        'Large storage capacity',
        'Shoe compartment',
        'Adjustable shoulder strap',
      ],
      specifications: {
        'Brand': 'TravelPro',
        'Material': 'Polyester',
        'Capacity': '35L',
        'Warranty': '6 Months',
      },
    ),

    Product(
      id: '12',
      name: 'Wireless Gaming Mouse',
      category: 'Gaming',
      imageUrl:
      'https://images.unsplash.com/photo-1527814050087-3793815479db?w=900',
      price: 1799,
      originalPrice: 2499,
      rating: 4.6,
      reviews: 2190,
      description:
      'Lightweight wireless gaming mouse with precise tracking and customizable controls.',
      highlights: [
        'High precision sensor',
        'Wireless connectivity',
        'RGB lighting',
      ],
      specifications: {
        'Brand': 'GameCore',
        'DPI': '12000 DPI',
        'Connection': '2.4GHz Wireless',
        'Battery': '70 Hours',
      },
    ),

    Product(
      id: '13',
      name: 'Smart LED Table Lamp',
      category: 'Home',
      imageUrl:
      'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=900',
      price: 1299,
      originalPrice: 1999,
      rating: 4.2,
      reviews: 845,
      description:
      'Modern smart LED table lamp with adjustable brightness for work and study.',
      highlights: [
        'Adjustable brightness',
        'Touch control',
        'Energy efficient LED',
      ],
      specifications: {
        'Brand': 'GlowHome',
        'Power': '10W',
        'Control': 'Touch',
        'Color Temperature': '3000K–6500K',
      },
    ),

    Product(
      id: '14',
      name: 'Fitness Yoga Mat',
      category: 'Sports',
      imageUrl:
      'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=900',
      price: 999,
      originalPrice: 1599,
      rating: 4.5,
      reviews: 1786,
      description:
      'Comfortable non-slip yoga mat designed for yoga, stretching and home workouts.',
      highlights: [
        'Non-slip surface',
        'Lightweight',
        'Easy to carry',
      ],
      specifications: {
        'Brand': 'FitLife',
        'Material': 'TPE',
        'Thickness': '6mm',
        'Length': '183cm',
      },
    ),
  ];

  List<Product> search(String query, {String? category, double? maxPrice, double? minRating}) {
    return products.where((p) {
      final matchesQuery = query.isEmpty ||
          p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.category.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = category == null || p.category == category;
      final matchesPrice = maxPrice == null || p.price <= maxPrice;
      final matchesRating = minRating == null || p.rating >= minRating;
      return matchesQuery && matchesCategory && matchesPrice && matchesRating;
    }).toList();
  }
}
