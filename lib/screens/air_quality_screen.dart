import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../theme/app_theme.dart';
import '../widgets/weather_card.dart';

class AirQualityScreen extends StatelessWidget {
  final AirQualityData airQuality;
  final String cityName;

  const AirQualityScreen({super.key, required this.airQuality, required this.cityName});

  Color _aqiColor(int aqi) {
    if (aqi <= 50) return AppTheme.success;
    if (aqi <= 100) return AppTheme.accent;
    if (aqi <= 150) return const Color(0xFFEF6C00);
    return const Color(0xFFD32F2F);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: Text('$cityName — Air Quality'),
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AQI gauge
            SurfaceCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 160,
                          child: CircularProgressIndicator(
                            value: airQuality.aqi / 300,
                            strokeWidth: 12,
                            backgroundColor: AppTheme.divider,
                            color: _aqiColor(airQuality.aqi),
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${airQuality.aqi}', style: TextStyle(color: _aqiColor(airQuality.aqi), fontSize: 42, fontWeight: FontWeight.w700)),
                            Text('AQI', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _aqiColor(airQuality.aqi).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      airQuality.aqiLabel,
                      style: TextStyle(color: _aqiColor(airQuality.aqi), fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Pollutant breakdown
            const Text('Pollutants', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _PollutantTile(label: 'PM2.5', value: airQuality.pm25, unit: 'µg/m³', maxVal: 75, color: AppTheme.secondary),
            _PollutantTile(label: 'PM10', value: airQuality.pm10, unit: 'µg/m³', maxVal: 150, color: AppTheme.accent),
            _PollutantTile(label: 'NO₂', value: airQuality.no2, unit: 'µg/m³', maxVal: 100, color: const Color(0xFF8B5CF6)),
            _PollutantTile(label: 'O₃', value: airQuality.o3, unit: 'µg/m³', maxVal: 120, color: AppTheme.success),
            _PollutantTile(label: 'CO', value: airQuality.co, unit: 'mg/m³', maxVal: 5, color: const Color(0xFFEC4899)),
            const SizedBox(height: 20),

            // Scale
            const Text('AQI Scale', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SurfaceCard(
              child: Column(
                children: [
                  _ScaleRow(range: '0 – 50', label: 'Good', color: AppTheme.success),
                  const Divider(height: 1),
                  _ScaleRow(range: '51 – 100', label: 'Moderate', color: AppTheme.accent),
                  const Divider(height: 1),
                  _ScaleRow(range: '101 – 150', label: 'Unhealthy for Sensitive', color: const Color(0xFFEF6C00)),
                  const Divider(height: 1),
                  _ScaleRow(range: '151 – 200', label: 'Unhealthy', color: const Color(0xFFD32F2F)),
                  const Divider(height: 1),
                  _ScaleRow(range: '201 – 300', label: 'Very Unhealthy', color: const Color(0xFF7B1FA2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PollutantTile extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final double maxVal;
  final Color color;

  const _PollutantTile({required this.label, required this.value, required this.unit, required this.maxVal, required this.color});

  @override
  Widget build(BuildContext context) {
    final progress = (value / maxVal).clamp(0.0, 1.0);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
              Text('$value $unit', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppTheme.divider,
              color: color,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScaleRow extends StatelessWidget {
  final String range;
  final String label;
  final Color color;

  const _ScaleRow({required this.range, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
          const SizedBox(width: 12),
          SizedBox(width: 70, child: Text(range, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12))),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
