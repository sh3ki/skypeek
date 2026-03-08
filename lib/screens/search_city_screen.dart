import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/weather_icon.dart';

class SearchCityScreen extends StatefulWidget {
  final void Function(CityWeather) onCitySelected;

  const SearchCityScreen({super.key, required this.onCitySelected});

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  final _controller = TextEditingController();
  String _query = '';
  int? _selectedIdx;

  List<CityWeather> get _filtered => MockData.cities
      .where((c) => c.city.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            const SizedBox(height: 8),
            if (_query.isEmpty) ...[
              _buildRecentLabel(),
              _buildRecentCities(),
              const SizedBox(height: 20),
              _buildPopularLabel(),
              _buildPopularChips(),
            ] else ...[
              Expanded(child: _buildSearchResults()),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cities',
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            'Browse and select a city',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [AppTheme.cardShadow],
        ),
        child: TextField(
          controller: _controller,
          onChanged: (v) => setState(() => _query = v),
          decoration: InputDecoration(
            hintText: 'Search city...',
            hintStyle: const TextStyle(color: AppTheme.textSecondary),
            prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.textSecondary),
            suffixIcon: _query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded,
                        color: AppTheme.textSecondary),
                    onPressed: () {
                      _controller.clear();
                      setState(() => _query = '');
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentLabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(
        'Available Cities',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget _buildRecentCities() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: MockData.cities.length,
      itemBuilder: (_, i) => _CityTile(
        city: MockData.cities[i],
        isSelected: _selectedIdx == i,
        onTap: () {
          setState(() => _selectedIdx = i);
          widget.onCitySelected(MockData.cities[i]);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '${MockData.cities[i].city} selected'),
              backgroundColor: AppTheme.primary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularLabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Text(
        'Quick Select',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget _buildPopularChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: MockData.cities.map((c) {
          return ActionChip(
            label: Text('${c.condition.emoji} ${c.city}'),
            onPressed: () {
              widget.onCitySelected(c);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${c.city} selected'),
                  backgroundColor: AppTheme.primary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            backgroundColor: AppTheme.primary.withOpacity(0.1),
            side: BorderSide(color: AppTheme.primary.withOpacity(0.3)),
            labelStyle: const TextStyle(
                color: AppTheme.primary, fontWeight: FontWeight.w700),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchResults() {
    final results = _filtered;
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off_rounded,
                color: AppTheme.textSecondary, size: 64),
            const SizedBox(height: 12),
            Text('No cities found for "$_query"',
                style: const TextStyle(color: AppTheme.textSecondary)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: results.length,
      itemBuilder: (_, i) => _CityTile(
        city: results[i],
        isSelected: false,
        onTap: () {
          widget.onCitySelected(results[i]);
          _controller.clear();
          setState(() => _query = '');
        },
      ),
    );
  }
}

class _CityTile extends StatelessWidget {
  final CityWeather city;
  final bool isSelected;
  final VoidCallback onTap;

  const _CityTile({
    required this.city,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? AppTheme.primary.withOpacity(0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? AppTheme.primary.withOpacity(0.5)
              : Colors.transparent,
        ),
        boxShadow: [AppTheme.cardShadow],
      ),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primary, AppTheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: WeatherIcon(condition: city.condition, size: 28),
          ),
        ),
        title: Text(
          city.city,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        subtitle: Text(
          '${city.condition.label} • ${city.country}',
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${city.tempC.round()}°C',
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: AppTheme.primary),
            ),
            Text(
              '${city.tempF.round()}°F',
              style: const TextStyle(
                  color: AppTheme.textSecondary, fontSize: 11),
            ),
          ],
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
