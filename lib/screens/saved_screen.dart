import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/saved_service.dart';
import 'restaurant_detail_screen.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Map<String, dynamic>> _saved = [];

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final saved = await SavedService.getSaved();
    setState(() => _saved = saved);
  }

  Future<void> _remove(String name) async {
    await SavedService.removeRestaurant(name);
    await _loadSaved();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$name removed from saved'),
          backgroundColor: AppColors.textPrimary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved', style: AppTextStyles.heading2),
      ),
      body: _saved.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_outline, size: 64, color: AppColors.textHint),
                  const SizedBox(height: AppSpacing.md),
                  const Text('No saved restaurants', style: AppTextStyles.heading3),
                  const SizedBox(height: AppSpacing.sm),
                  const Text('Tap the heart on any restaurant to save it', style: AppTextStyles.bodySecondary),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _saved.length,
              itemBuilder: (context, index) {
                final r = _saved[index];
                return Dismissible(
                  key: Key(r['name']),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => _remove(r['name']),
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: AppSpacing.lg),
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
                  ),
                  child: GestureDetector(
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
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite, color: AppColors.primary),
                          onPressed: () => _remove(r['name']),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}