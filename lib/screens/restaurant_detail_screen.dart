import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.restaurant;

    return Scaffold(
      appBar: AppBar(
        title: Text(r['name'], style: AppTextStyles.heading2),
        actions: [
          IconButton(
            icon: Icon(
              _isSaved ? Icons.favorite : Icons.favorite_outline,
              color: _isSaved ? AppColors.primary : AppColors.textSecondary,
            ),
            onPressed: () {
              setState(() => _isSaved = !_isSaved);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isSaved ? '${r['name']} saved!' : '${r['name']} removed from saved'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: AppColors.textPrimary,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.border),
            ),
            child: Center(
              child: Text(r['image'], style: const TextStyle(fontSize: 80)),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: Text(r['name'], style: AppTextStyles.heading2),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: r['open'] ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(
                  r['open'] ? 'Open' : 'Closed',
                  style: TextStyle(
                    fontSize: 13,
                    color: r['open'] ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(r['cuisine'], style: AppTextStyles.bodySecondary),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _InfoChip(icon: Icons.star, label: '${r['rating']}', color: Colors.amber),
              const SizedBox(width: AppSpacing.sm),
              _InfoChip(icon: Icons.location_on_outlined, label: r['distance'], color: AppColors.primary),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Divider(),
          const SizedBox(height: AppSpacing.md),
          const Text('About', style: AppTextStyles.heading3),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'A wonderful place to enjoy delicious ${r['cuisine']} food. Known for fresh ingredients and great atmosphere.',
            style: AppTextStyles.body,
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Opening hours', style: AppTextStyles.heading3),
          const SizedBox(height: AppSpacing.sm),
          _HoursRow(day: 'Monday – Friday', hours: '11:00 – 22:00'),
          _HoursRow(day: 'Saturday', hours: '12:00 – 23:00'),
          _HoursRow(day: 'Sunday', hours: '12:00 – 21:00'),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.directions, color: Colors.white),
            label: const Text('Get directions', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.bodySecondary),
        ],
      ),
    );
  }
}

class _HoursRow extends StatelessWidget {
  final String day;
  final String hours;

  const _HoursRow({required this.day, required this.hours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: AppTextStyles.bodySecondary),
          Text(hours, style: AppTextStyles.body),
        ],
      ),
    );
  }
}