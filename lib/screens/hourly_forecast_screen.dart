import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/weather_model.dart';
import '../widgets/weather_icon.dart';

class HourlyForecastScreen extends StatelessWidget {
  final CityWeather city;
  final bool useCelsius;

  const HourlyForecastScreen({
    super.key,
    required this.city,
    required this.useCelsius,
  });

  double _c(double c) => useCelsius ? c : c * 9 / 5 + 32;

  @override
  Widget build(BuildContext context) {
    final temps = city.hourly.map((h) => _c(h.tempC)).toList();
    final minTemp = temps.reduce((a, b) => a < b ? a : b) - 2;
    final maxTemp = temps.reduce((a, b) => a > b ? a : b) + 2;

    return Scaffold(
      body: Stack(
        children: [
          WeatherConditionBackground(
            condition: city.condition,
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(context),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Text(
                      '24-Hour Forecast',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Line chart
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: LineChart(
                        LineChartData(
                          minY: minTemp,
                          maxY: maxTemp,
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 4,
                                getTitlesWidget: (val, _) {
                                  final idx = val.toInt();
                                  if (idx < 0 || idx >= city.hourly.length) {
                                    return const SizedBox.shrink();
                                  }
                                  return Text(
                                    city.hourly[idx].hour.replaceAll(' AM', 'a').replaceAll(' PM', 'p'),
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 9),
                                  );
                                },
                              ),
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: List.generate(
                                city.hourly.length,
                                (i) => FlSpot(i.toDouble(), temps[i]),
                              ),
                              isCurved: true,
                              color: Colors.white,
                              barWidth: 2.5,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.white.withOpacity(0.15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Hourly list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: city.hourly.length,
                      itemBuilder: (_, i) => _HourlyRow(
                        hourly: city.hourly[i],
                        temp: '${temps[i].round()}°',
                        isNow: i == 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Colors.white, size: 22),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                city.city,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                city.condition.label,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HourlyRow extends StatelessWidget {
  final HourlyForecast hourly;
  final String temp;
  final bool isNow;

  const _HourlyRow({
    required this.hourly,
    required this.temp,
    required this.isNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isNow
            ? Colors.white.withOpacity(0.28)
            : Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: isNow
                ? Colors.white.withOpacity(0.6)
                : Colors.white.withOpacity(0.15)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 54,
            child: Text(
              isNow ? 'Now' : hourly.hour,
              style: TextStyle(
                color: isNow ? Colors.white : Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          WeatherIcon(condition: hourly.condition, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hourly.condition.label,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.water_drop_rounded,
                  color: Colors.lightBlue, size: 14),
              const SizedBox(width: 3),
              Text(
                '${hourly.rainChance}%',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Text(
            temp,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
