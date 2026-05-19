import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../theme/app_theme.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';
import 'restaurant_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _position;
  bool _loadingLocation = false;
  Map<String, dynamic>? _weather;

  final List<Map<String, dynamic>> _restaurants = const [
    {'name': 'La Piazza', 'cuisine': 'Italian', 'rating': 4.5, 'distance': '0.3 km', 'image': '🍕', 'open': true, 'lat': 46.5547, 'lng': 15.6459},
    {'name': 'Sakura Garden', 'cuisine': 'Japanese', 'rating': 4.8, 'distance': '0.7 km', 'image': '🍣', 'open': true, 'lat': 46.5560, 'lng': 15.6480},
    {'name': 'El Rincón', 'cuisine': 'Spanish', 'rating': 4.2, 'distance': '1.1 km', 'image': '🥘', 'open': false, 'lat': 46.5530, 'lng': 15.6440},
    {'name': 'Burger House', 'cuisine': 'American', 'rating': 4.0, 'distance': '0.5 km', 'image': '🍔', 'open': true, 'lat': 46.5550, 'lng': 15.6470},
    {'name': 'Green Bowl', 'cuisine': 'Healthy', 'rating': 4.6, 'distance': '1.4 km', 'image': '🥗', 'open': true, 'lat': 46.5520, 'lng': 15.6500},
  ];

  List<Map<String, dynamic>> get _sortedRestaurants {
    if (_position == null) return _restaurants;
    final sorted = [..._restaurants];
    sorted.sort((a, b) {
      final distA = Geolocator.distanceBetween(_position!.latitude, _position!.longitude, a['lat'], a['lng']);
      final distB = Geolocator.distanceBetween(_position!.latitude, _position!.longitude, b['lat'], b['lng']);
      return distA.compareTo(distB);
    });
    return sorted;
  }

  Future<void> _getLocation() async {
    setState(() => _loadingLocation = true);
    final position = await LocationService.getCurrentPosition();
    if (position != null) {
      final weather = await WeatherService.getWeather(position.latitude, position.longitude);
      setState(() {
        _position = position;
        _weather = weather;
        _loadingLocation = false;
      });
    } else {
      setState(() => _loadingLocation = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NearEats', style: AppTextStyles.heading2),
        actions: [
          IconButton(
            icon: _loadingLocation
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary))
                : Icon(_position != null ? Icons.location_on : Icons.location_off, color: _position != null ? AppColors.primary : AppColors.textHint),
            onPressed: _getLocation,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          if (_weather != null)
            Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Text(WeatherService.getWeatherEmoji(_weather!['icon']), style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: AppSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_weather!['temp']}°C — ${_weather!['description']}', style: AppTextStyles.body),
                      const Text('Weather near you', style: AppTextStyles.bodySecondary),
                    ],
                  ),
                ],
              ),
            ),
          if (_position != null)
            Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.primary, size: 18),
                  SizedBox(width: 8),
                  Text('Showing restaurants near your location', style: AppTextStyles.bodySecondary),
                ],
              ),
            ),
          const Text('Restaurants near you', style: AppTextStyles.heading3),
          const SizedBox(height: AppSpacing.md),
          ..._sortedRestaurants.asMap().entries.map(
            (entry) => _AnimatedRestaurantCard(
              restaurant: entry.value,
              index: entry.key,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedRestaurantCard extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  final int index;

  const _AnimatedRestaurantCard({required this.restaurant, required this.index});

  @override
  State<_AnimatedRestaurantCard> createState() => _AnimatedRestaurantCardState();
}

class _AnimatedRestaurantCardState extends State<_AnimatedRestaurantCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: _RestaurantCard(restaurant: widget.restaurant),
      ),
    );
  }
}

class _RestaurantCard extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const _RestaurantCard({required this.restaurant});

  @override
  State<_RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<_RestaurantCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RestaurantDetailScreen(restaurant: widget.restaurant),
          ),
        );
      },
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
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
                child: Text(widget.restaurant['image'], style: const TextStyle(fontSize: 28)),
              ),
            ),
            title: Text(widget.restaurant['name'], style: AppTextStyles.heading3),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(widget.restaurant['cuisine'], style: AppTextStyles.bodySecondary),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text('${widget.restaurant['rating']}', style: AppTextStyles.caption),
                    const SizedBox(width: 8),
                    const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(widget.restaurant['distance'], style: AppTextStyles.caption),
                  ],
                ),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: widget.restaurant['open'] ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Text(
                widget.restaurant['open'] ? 'Open' : 'Closed',
                style: TextStyle(
                  fontSize: 12,
                  color: widget.restaurant['open'] ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}