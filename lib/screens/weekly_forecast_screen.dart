import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../theme/app_theme.dart';
import '../widgets/weather_card.dart';

class WeeklyForecastScreen extends StatelessWidget {
  final CityWeather city;
  final bool useCelsius;

  const WeeklyForecastScreen({super.key, required this.city, required this.useCelsius});

  String _temp(double c) => useCelsius ? '${c.round()}°' : '${(c * 9 / 5 + 32).round()}°';

  @override
  Widget build(BuildContext context) {
    final allHighs = city.daily.map((d) => useCelsius ? d.highC : d.highF).toList();
    final allLows = city.daily.map((d) => useCelsius ? d.lowC : d.lowF).toList();
    final globalHigh = allHighs.reduce((a, b) => a > b ? a : b);
    final globalLow = allLows.reduce((a, b) => a < b ? a : b);
    final range = globalHigh - globalLow;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: Text('${city.city} — 7-Day Forecast'),
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary
            SurfaceCard(
              child: Row(
                children: [
                  WeatherIcon(condition: city.condition, size: 48),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('This Week', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                      Text(
                        '${_temp(city.daily.map((d) => d.highC).reduce((a, b) => a > b ? a : b))} High / ${_temp(city.daily.map((d) => d.lowC).reduce((a, b) => a < b ? a : b))} Low',
                        style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Daily list
            ...city.daily.asMap().entries.map((e) {
              final d = e.value;
              final high = useCelsius ? d.highC : d.highF;
              final low = useCelsius ? d.lowC : d.lowF;
              final barStart = range > 0 ? (low - globalLow) / range : 0.0;
              final barEnd = range > 0 ? (high - globalLow) / range : 1.0;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Row(
                  children: [
                    SizedBox(width: 36, child: Text(d.day, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600))),
                    const SizedBox(width: 8),
                    Icon(d.condition.icon, color: AppTheme.conditionColor(d.condition.label), size: 22),
                    const SizedBox(width: 10),
                    Icon(Icons.water_drop_rounded, color: AppTheme.secondary.withOpacity(0.4), size: 14),
                    SizedBox(width: 30, child: Text('${d.rainChance}%', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11))),
                    const SizedBox(width: 8),
                    SizedBox(width: 32, child: Text(_temp(d.lowC), style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12))),
                    Expanded(
                      child: Container(
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.divider,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 1,
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Stack(
                              children: [
                                Positioned(
                                  left: constraints.maxWidth * barStart,
                                  right: constraints.maxWidth * (1 - barEnd),
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.secondary,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(width: 32, child: Text(_temp(d.highC), textAlign: TextAlign.end, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 12, fontWeight: FontWeight.w600))),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),

            // Humidity row
            const Text('Humidity', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SizedBox(
              height: 64,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: city.daily.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, i) {
                  final d = city.daily[i];
                  return Container(
                    width: 56,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(d.day, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text('${d.humidity}%', style: const TextStyle(color: AppTheme.secondary, fontSize: 14, fontWeight: FontWeight.w700)),
                      ],
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
