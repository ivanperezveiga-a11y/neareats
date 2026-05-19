import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> _restaurants = const [
    {
      'name': 'La Piazza',
      'cuisine': 'Italian',
      'rating': 4.5,
      'distance': '0.3 km',
      'image': '🍕',
      'open': true,
    },
    {
      'name': 'Sakura Garden',
      'cuisine': 'Japanese',
      'rating': 4.8,
      'distance': '0.7 km',
      'image': '🍣',
      'open': true,
    },
    {
      'name': 'El Rincón',
      'cuisine': 'Spanish',
      'rating': 4.2,
      'distance': '1.1 km',
      'image': '🥘',
      'open': false,
    },
    {
      'name': 'Burger House',
      'cuisine': 'American',
      'rating': 4.0,
      'distance': '0.5 km',
      'image': '🍔',
      'open': true,
    },
    {
      'name': 'Green Bowl',
      'cuisine': 'Healthy',
      'rating': 4.6,
      'distance': '1.4 km',
      'image': '🥗',
      'open': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NearEats', style: AppTextStyles.heading2),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const Text('Restaurants near you', style: AppTextStyles.heading3),
          const SizedBox(height: AppSpacing.md),
          ..._restaurants.map((r) => _RestaurantCard(restaurant: r)),
        ],
      ),
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final Map<String, dynamic> restaurant;

  const _RestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Center(
            child: Text(restaurant['image'], style: const TextStyle(fontSize: 28)),
          ),
        ),
        title: Text(restaurant['name'], style: AppTextStyles.heading3),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(restaurant['cuisine'], style: AppTextStyles.bodySecondary),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 4),
                Text('${restaurant['rating']}', style: AppTextStyles.caption),
                const SizedBox(width: 8),
                const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textHint),
                const SizedBox(width: 4),
                Text(restaurant['distance'], style: AppTextStyles.caption),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: restaurant['open'] ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          child: Text(
            restaurant['open'] ? 'Open' : 'Closed',
            style: TextStyle(
              fontSize: 12,
              color: restaurant['open'] ? AppColors.success : AppColors.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}