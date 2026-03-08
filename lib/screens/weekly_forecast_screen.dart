import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../widgets/weather_icon.dart';

class WeeklyForecastScreen extends StatelessWidget {
  final CityWeather city;
  final bool useCelsius;

  const WeeklyForecastScreen({
    super.key,
    required this.city,
    required this.useCelsius,
  });

  String _temp(double c) =>
      useCelsius ? '${c.round()}°' : '${(c * 9 / 5 + 32).round()}°';

  @override
  Widget build(BuildContext context) {
    final allHighs = city.daily.map((d) => useCelsius ? d.highC : d.highF).toList();
    final allLows = city.daily.map((d) => useCelsius ? d.lowC : d.lowF).toList();
    final maxHigh = allHighs.reduce((a, b) => a > b ? a : b);
    final minLow = allLows.reduce((a, b) => a < b ? a : b);

    return Scaffold(
      body: WeatherConditionBackground(
        condition: city.condition,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Summary strip
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.25)),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _SummaryItem(
                                label: 'City',
                                value: city.city),
                            _SummaryItem(
                                label: 'High',
                                value: _temp(allHighs.reduce((a, b) => a > b ? a : b))),
                            _SummaryItem(
                                label: 'Low',
                                value: _temp(allLows.reduce((a, b) => a < b ? a : b))),
                            _SummaryItem(
                                label: 'Humidity',
                                value: '${city.humidity}%'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '7-Day Forecast',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...city.daily.asMap().entries.map((entry) {
                        final i = entry.key;
                        final d = entry.value;
                        final high = useCelsius ? d.highC : d.highF;
                        final low = useCelsius ? d.lowC : d.lowF;
                        return _DailyRow(
                          day: d,
                          highTemp: _temp(high),
                          lowTemp: _temp(low),
                          high: high,
                          low: low,
                          maxHigh: maxHigh,
                          minLow: minLow,
                          isToday: i == 0,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '7-Day Forecast',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                city.city,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const Spacer(),
          WeatherIcon(condition: city.condition, size: 48),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.white60, fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
      ],
    );
  }
}

class _DailyRow extends StatelessWidget {
  final DailyForecast day;
  final String highTemp;
  final String lowTemp;
  final double high;
  final double low;
  final double maxHigh;
  final double minLow;
  final bool isToday;

  const _DailyRow({
    required this.day,
    required this.highTemp,
    required this.lowTemp,
    required this.high,
    required this.low,
    required this.maxHigh,
    required this.minLow,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    final range = maxHigh - minLow;
    final startFrac = range == 0 ? 0.0 : ((low - minLow) / range).clamp(0.0, 1.0);
    final endFrac = range == 0 ? 1.0 : ((high - minLow) / range).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isToday
            ? Colors.white.withOpacity(0.28)
            : Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: isToday
                ? Colors.white.withOpacity(0.6)
                : Colors.white.withOpacity(0.15)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          SizedBox(
            width: 46,
            child: Text(
              day.day,
              style: TextStyle(
                color: isToday ? Colors.white : Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          WeatherIcon(condition: day.condition, size: 30),
          const SizedBox(width: 10),
          Row(
            children: [
              const Icon(Icons.water_drop_rounded,
                  color: Colors.lightBlue, size: 13),
              const SizedBox(width: 3),
              Text(
                '${day.rainChance}%',
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
          const Spacer(),
          Text(
            lowTemp,
            style: const TextStyle(
                color: Colors.white60, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 8),
          // Temp range bar
          SizedBox(
            width: 70,
            height: 6,
            child: LayoutBuilder(builder: (_, constraints) {
              final totalW = constraints.maxWidth;
              return Stack(
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Positioned(
                    left: startFrac * totalW,
                    width: (endFrac - startFrac) * totalW,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightBlue.shade300,
                            Colors.amber.shade300,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(width: 8),
          Text(
            highTemp,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
