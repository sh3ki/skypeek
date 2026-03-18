import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../theme/app_theme.dart';
import '../widgets/weather_card.dart';
import 'air_quality_screen.dart';
import 'weekly_forecast_screen.dart';

class DashboardScreen extends StatelessWidget {
  final CityWeather city;
  final bool useCelsius;

  const DashboardScreen({super.key, required this.city, required this.useCelsius});

  String _temp(double c) => useCelsius ? '${c.round()}°C' : '${(c * 9 / 5 + 32).round()}°F';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.location_on_rounded, color: AppTheme.secondary, size: 18),
                const SizedBox(width: 6),
                Text(city.city, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                Text(', ${city.country}', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
                const Spacer(),
                Text(city.timezone, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
              ],
            ),
            const SizedBox(height: 24),

            // Hero Temperature
            SurfaceCard(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_temp(city.tempC), style: const TextStyle(color: AppTheme.textPrimary, fontSize: 56, fontWeight: FontWeight.w700, height: 1)),
                        const SizedBox(height: 4),
                        Text(city.condition.label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 16)),
                        const SizedBox(height: 2),
                        Text('Feels like ${_temp(city.feelsLikeC)}', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                      ],
                    ),
                  ),
                  WeatherIcon(condition: city.condition, size: 72),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Hourly scroll
            const Text('Hourly', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: city.hourly.length,
                itemBuilder: (context, i) {
                  final h = city.hourly[i];
                  return HourlyCard(
                    hour: h.hour,
                    temp: _temp(h.tempC),
                    condition: h.condition,
                    isNow: i == 0,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Metrics grid
            const Text('Details', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                MetricCard(icon: Icons.water_drop_rounded, label: 'Humidity', value: '${city.humidity}', unit: '%'),
                MetricCard(icon: Icons.air_rounded, label: 'Wind', value: '${city.windSpeedKmh}', unit: 'km/h'),
                MetricCard(icon: Icons.wb_sunny_outlined, label: 'UV Index', value: '${city.uvIndex}'),
                MetricCard(icon: Icons.compress_rounded, label: 'Pressure', value: '${city.pressure}', unit: 'hPa'),
                MetricCard(icon: Icons.visibility_rounded, label: 'Visibility', value: '${city.visibility}', unit: 'km'),
                MetricCard(icon: Icons.eco_rounded, label: 'Air Quality', value: '${city.airQuality.aqi}', unit: city.airQuality.aqiLabel),
              ],
            ),
            const SizedBox(height: 20),

            // Sunrise / Sunset
            SurfaceCard(
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: AppTheme.accent.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.wb_twilight_rounded, color: AppTheme.accent, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Sunrise', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                            Text(city.sunrise, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 36, color: AppTheme.divider),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.nights_stay_rounded, color: AppTheme.primary.withOpacity(0.6), size: 20),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Sunset', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                              Text(city.sunset, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Quick links
            Row(
              children: [
                Expanded(
                  child: _QuickLink(
                    icon: Icons.calendar_view_week_rounded,
                    label: '7-Day Forecast',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WeeklyForecastScreen(city: city, useCelsius: useCelsius))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickLink(
                    icon: Icons.eco_rounded,
                    label: 'Air Quality',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AirQualityScreen(airQuality: city.airQuality, cityName: city.city))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickLink({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.secondary, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(label, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600))),
            const Icon(Icons.chevron_right_rounded, color: AppTheme.textSecondary, size: 18),
          ],
        ),
      ),
    );
  }
}
