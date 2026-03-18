import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/weather_model.dart';
import '../theme/app_theme.dart';
import '../widgets/weather_card.dart';

class HourlyForecastScreen extends StatelessWidget {
  final CityWeather city;
  final bool useCelsius;

  const HourlyForecastScreen({super.key, required this.city, required this.useCelsius});

  double _t(double c) => useCelsius ? c : c * 9 / 5 + 32;
  String _temp(double c) => '${_t(c).round()}°';

  @override
  Widget build(BuildContext context) {
    final temps = city.hourly.map((h) => _t(h.tempC)).toList();
    final minT = temps.reduce((a, b) => a < b ? a : b) - 3;
    final maxT = temps.reduce((a, b) => a > b ? a : b) + 3;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.schedule_rounded, color: AppTheme.secondary, size: 22),
                const SizedBox(width: 8),
                const Text('Hourly Forecast', style: TextStyle(color: AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                const Spacer(),
                Text(city.city, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 24),

            // Temperature chart
            SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Temperature Trend', style: TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        minY: minT,
                        maxY: maxT,
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: 5,
                          getDrawingHorizontalLine: (value) => FlLine(color: AppTheme.divider, strokeWidth: 1),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36,
                            getTitlesWidget: (value, meta) => Text('${value.round()}°', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10)),
                          )),
                          bottomTitles: AxisTitles(sideTitles: SideTitles(
                            showTitles: true,
                            interval: 2,
                            getTitlesWidget: (value, meta) {
                              final i = value.toInt();
                              if (i < 0 || i >= city.hourly.length) return const SizedBox.shrink();
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(city.hourly[i].hour, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 9)),
                              );
                            },
                          )),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(temps.length, (i) => FlSpot(i.toDouble(), temps[i])),
                            isCurved: true,
                            color: AppTheme.secondary,
                            barWidth: 3,
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                radius: 3,
                                color: Colors.white,
                                strokeWidth: 2,
                                strokeColor: AppTheme.secondary,
                              ),
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              color: AppTheme.secondary.withOpacity(0.08),
                            ),
                          ),
                        ],
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                return LineTooltipItem(
                                  '${spot.y.round()}°',
                                  const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Rain chance chart
            SurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rain Probability', style: TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 160,
                    child: BarChart(
                      BarChartData(
                        maxY: 100,
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: 25,
                          getDrawingHorizontalLine: (value) => FlLine(color: AppTheme.divider, strokeWidth: 1),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) => Text('${value.round()}%', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10)),
                          )),
                          bottomTitles: AxisTitles(sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final i = value.toInt();
                              if (i < 0 || i >= city.hourly.length) return const SizedBox.shrink();
                              return Text(city.hourly[i].hour.replaceAll(' PM', 'p').replaceAll(' AM', 'a').replaceAll('Now', 'Now'), style: const TextStyle(color: AppTheme.textSecondary, fontSize: 8));
                            },
                          )),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: List.generate(city.hourly.length, (i) {
                          return BarChartGroupData(x: i, barRods: [
                            BarChartRodData(
                              toY: city.hourly[i].rainChance.toDouble(),
                              color: AppTheme.secondary.withOpacity(0.7),
                              width: 12,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                          ]);
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Hourly detail list
            const Text('Hour by Hour', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...city.hourly.asMap().entries.map((e) {
              final h = e.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: e.key == 0 ? AppTheme.primary : AppTheme.cardBg,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: e.key == 0 ? null : AppTheme.cardShadow,
                ),
                child: Row(
                  children: [
                    SizedBox(width: 50, child: Text(h.hour, style: TextStyle(color: e.key == 0 ? Colors.white70 : AppTheme.textSecondary, fontSize: 12, fontWeight: FontWeight.w600))),
                    Icon(h.condition.icon, color: e.key == 0 ? Colors.white : AppTheme.conditionColor(h.condition.label), size: 20),
                    const SizedBox(width: 10),
                    Expanded(child: Text(h.condition.label, style: TextStyle(color: e.key == 0 ? Colors.white : AppTheme.textPrimary, fontSize: 13))),
                    Icon(Icons.water_drop_rounded, color: e.key == 0 ? Colors.white54 : AppTheme.secondary.withOpacity(0.5), size: 14),
                    const SizedBox(width: 4),
                    SizedBox(width: 32, child: Text('${h.rainChance}%', style: TextStyle(color: e.key == 0 ? Colors.white70 : AppTheme.textSecondary, fontSize: 12))),
                    const SizedBox(width: 8),
                    Text(_temp(h.tempC), style: TextStyle(color: e.key == 0 ? Colors.white : AppTheme.textPrimary, fontSize: 15, fontWeight: FontWeight.w700)),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
