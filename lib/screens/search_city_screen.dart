import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../theme/app_theme.dart';
import '../widgets/weather_card.dart';

class SearchCityScreen extends StatefulWidget {
  final List<CityWeather> cities;
  final int selectedIndex;
  final bool useCelsius;
  final ValueChanged<int> onCitySelected;

  const SearchCityScreen({super.key, required this.cities, required this.selectedIndex, required this.useCelsius, required this.onCitySelected});

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  String _query = '';

  List<MapEntry<int, CityWeather>> get _filtered {
    final entries = widget.cities.asMap().entries.toList();
    if (_query.isEmpty) return entries;
    return entries.where((e) => e.value.city.toLowerCase().contains(_query.toLowerCase()) || e.value.country.toLowerCase().contains(_query.toLowerCase())).toList();
  }

  String _temp(double c) => widget.useCelsius ? '${c.round()}°C' : '${(c * 9 / 5 + 32).round()}°F';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_city_rounded, color: AppTheme.secondary, size: 22),
                const SizedBox(width: 8),
                const Text('Cities', style: TextStyle(color: AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 16),

            // Search bar
            Container(
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppTheme.cardShadow,
              ),
              child: TextField(
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Search cities...',
                  hintStyle: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5)),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.textSecondary),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text('${_filtered.length} cities', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: _filtered.length,
                itemBuilder: (context, i) {
                  final entry = _filtered[i];
                  final city = entry.value;
                  final isSelected = entry.key == widget.selectedIndex;

                  return GestureDetector(
                    onTap: () => widget.onCitySelected(entry.key),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primary : AppTheme.cardBg,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: isSelected ? null : AppTheme.cardShadow,
                        border: isSelected ? null : Border.all(color: Colors.transparent),
                      ),
                      child: Row(
                        children: [
                          WeatherIcon(
                            condition: city.condition,
                            size: 44,
                            color: isSelected ? Colors.white : null,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(city.city, style: TextStyle(color: isSelected ? Colors.white : AppTheme.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 2),
                                Text('${city.country} • ${city.condition.label}', style: TextStyle(color: isSelected ? Colors.white70 : AppTheme.textSecondary, fontSize: 12)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(_temp(city.tempC), style: TextStyle(color: isSelected ? Colors.white : AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.water_drop_rounded, color: isSelected ? Colors.white54 : AppTheme.secondary.withOpacity(0.5), size: 12),
                                  const SizedBox(width: 2),
                                  Text('${city.humidity}%', style: TextStyle(color: isSelected ? Colors.white70 : AppTheme.textSecondary, fontSize: 11)),
                                ],
                              ),
                            ],
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 8),
                            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
