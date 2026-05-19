import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/saved_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  int _savedCount = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedCount();
  }

  Future<void> _loadSavedCount() async {
    final saved = await SavedService.getSaved();
    setState(() => _savedCount = saved.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: AppTextStyles.heading2),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: const Center(
                    child: Text('🍽️', style: TextStyle(fontSize: 40)),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const Text('Ivan Perez', style: AppTextStyles.heading2),
                const SizedBox(height: 4),
                const Text('ivan@email.com', style: AppTextStyles.bodySecondary),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Expanded(child: _StatCard(label: 'Saved', value: '$_savedCount')),
                Container(width: 1, height: 60, color: AppColors.border),
                const Expanded(child: _StatCard(label: 'Visited', value: '12')),
                Container(width: 1, height: 60, color: AppColors.border),
                const Expanded(child: _StatCard(label: 'Reviews', value: '5')),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Settings', style: AppTextStyles.heading3),
          const SizedBox(height: AppSpacing.sm),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Dark mode', style: AppTextStyles.body),
                  subtitle: const Text('Switch app theme', style: AppTextStyles.bodySecondary),
                  secondary: const Icon(Icons.dark_mode_outlined, color: AppColors.textSecondary),
                  value: _darkMode,
                  activeColor: AppColors.primary,
                  onChanged: (value) => setState(() => _darkMode = value),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Notifications', style: AppTextStyles.body),
                  subtitle: const Text('Receive restaurant updates', style: AppTextStyles.bodySecondary),
                  secondary: const Icon(Icons.notifications_outlined, color: AppColors.textSecondary),
                  value: _notifications,
                  activeColor: AppColors.primary,
                  onChanged: (value) => setState(() => _notifications = value),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.language_outlined, color: AppColors.textSecondary),
                  title: const Text('Language', style: AppTextStyles.body),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('English', style: AppTextStyles.bodySecondary),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right, color: AppColors.textHint),
                    ],
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: AppColors.textSecondary),
                  title: const Text('About', style: AppTextStyles.body),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('NearEats', style: AppTextStyles.heading3),
                        content: const Text('Version 1.0.0\nDiscover restaurants near you.', style: AppTextStyles.body),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK', style: TextStyle(color: AppColors.primary)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: AppColors.error),
            label: const Text('Log out', style: TextStyle(color: AppColors.error)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              side: const BorderSide(color: AppColors.error),
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

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.heading2),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.bodySecondary),
        ],
      ),
    );
  }
}