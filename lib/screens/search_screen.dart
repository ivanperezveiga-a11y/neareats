import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'restaurant_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';
  String _selectedCuisine = 'All';

  final List<String> _cuisines = ['All', 'Italian', 'Japanese', 'Spanish', 'American', 'Healthy'];

  final List<Map<String, dynamic>> _allRestaurants = const [
    {'name': 'La Piazza', 'cuisine': 'Italian', 'rating': 4.5, 'distance': '0.3 km', 'image': '🍕', 'open': true},
    {'name': 'Sakura Garden', 'cuisine': 'Japanese', 'rating': 4.8, 'distance': '0.7 km', 'image': '🍣', 'open': true},
    {'name': 'El Rincón', 'cuisine': 'Spanish', 'rating': 4.2, 'distance': '1.1 km', 'image': '🥘', 'open': false},
    {'name': 'Burger House', 'cuisine': 'American', 'rating': 4.0, 'distance': '0.5 km', 'image': '🍔', 'open': true},
    {'name': 'Green Bowl', 'cuisine': 'Healthy', 'rating': 4.6, 'distance': '1.4 km', 'image': '🥗', 'open': true},
  ];

  List<Map<String, dynamic>> get _filtered {
    return _allRestaurants.where((r) {
      final matchesQuery = r['name'].toLowerCase().contains(_query.toLowerCase()) ||
          r['cuisine'].toLowerCase().contains(_query.toLowerCase());
      final matchesCuisine = _selectedCuisine == 'All' || r['cuisine'] == _selectedCuisine;
      return matchesQuery && matchesCuisine;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search', style: AppTextStyles.heading2),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TextField(
              controller: _controller,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Search restaurants...',
                prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppColors.textHint),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              scrollDirection: Axis.horizontal,
              itemCount: _cuisines.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cuisine = _cuisines[index];
                final isSelected = cuisine == _selectedCuisine;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCuisine = cuisine),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                      ),
                    ),
                    child: Text(
                      cuisine,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 64, color: AppColors.textHint),
                        const SizedBox(height: AppSpacing.md),
                        const Text('No results found', style: AppTextStyles.heading3),
                        const SizedBox(height: AppSpacing.sm),
                        Text('Try a different search term', style: AppTextStyles.bodySecondary),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final r = _filtered[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RestaurantDetailScreen(restaurant: r),
                          ),
                        ),
                        child: Container(
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
                                child: Text(r['image'], style: const TextStyle(fontSize: 28)),
                              ),
                            ),
                            title: Text(r['name'], style: AppTextStyles.heading3),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(r['cuisine'], style: AppTextStyles.bodySecondary),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 14, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text('${r['rating']}', style: AppTextStyles.caption),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textHint),
                                    const SizedBox(width: 4),
                                    Text(r['distance'], style: AppTextStyles.caption),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: r['open'] ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(AppRadius.full),
                              ),
                              child: Text(
                                r['open'] ? 'Open' : 'Closed',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: r['open'] ? AppColors.success : AppColors.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}