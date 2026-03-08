import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../theme/app_theme.dart';
import '../widgets/weather_card.dart';

class AirQualityScreen extends StatelessWidget {
  final CityWeather city;

  const AirQualityScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final aq = city.airQuality;
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildAqiGauge(aq),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Pollutants',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 12),
              _buildPollutants(aq),
              const SizedBox(height: 20),
              _buildHealthTips(aq.aqi),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 20, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: AppTheme.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Air Quality',
                  style: Theme.of(context).textTheme.headlineMedium),
              Text(city.city,
                  style: const TextStyle(
                      color: AppTheme.textSecondary, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAqiGauge(AirQualityData aq) {
    final color = _aqiColor(aq.aqi);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SurfaceCard(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [color.withOpacity(0.3), color.withOpacity(0.05)],
                    ),
                    border: Border.all(color: color, width: 3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${aq.aqi}',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: color,
                        ),
                      ),
                      const Text('AQI',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textSecondary)),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          aq.aqiLabel,
                          style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w800,
                              fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _aqiDescription(aq.aqi),
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // AQI scale bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 12,
                child: Row(
                  children: [
                    Expanded(
                        flex: 50,
                        child: Container(color: Colors.green.shade400)),
                    Expanded(
                        flex: 50,
                        child: Container(color: Colors.yellow.shade600)),
                    Expanded(
                        flex: 50,
                        child: Container(color: Colors.orange.shade500)),
                    Expanded(
                        flex: 50,
                        child: Container(color: Colors.red.shade500)),
                    Expanded(
                        flex: 50,
                        child: Container(color: Colors.purple.shade700)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('0', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                Text('50', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                Text('100', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                Text('150', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                Text('200', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
                Text('300+', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollutants(AirQualityData aq) {
    final pollutants = [
      _Pollutant('PM2.5', aq.pm25, 25, 'μg/m³', 'Fine particles'),
      _Pollutant('PM10', aq.pm10, 50, 'μg/m³', 'Coarse particles'),
      _Pollutant('NO₂', aq.no2, 60, 'μg/m³', 'Nitrogen dioxide'),
      _Pollutant('O₃', aq.o3, 100, 'μg/m³', 'Ozone'),
      _Pollutant('CO', aq.co, 4, 'mg/m³', 'Carbon monoxide'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SurfaceCard(
        child: Column(
          children: pollutants
              .map((p) => _PollutantRow(pollutant: p))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildHealthTips(int aqi) {
    final tips = _healthTips(aqi);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SurfaceCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.health_and_safety_rounded,
                    color: _aqiColor(aqi), size: 20),
                const SizedBox(width: 8),
                const Text('Health Recommendations',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 15)),
              ],
            ),
            const SizedBox(height: 12),
            ...tips.map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_outline_rounded,
                          color: AppTheme.primary, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(t,
                            style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 13)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Color _aqiColor(int aqi) {
    if (aqi <= 50) return Colors.green.shade500;
    if (aqi <= 100) return Colors.yellow.shade700;
    if (aqi <= 150) return Colors.orange.shade600;
    if (aqi <= 200) return Colors.red.shade500;
    return Colors.purple.shade700;
  }

  String _aqiDescription(int aqi) {
    if (aqi <= 50) return 'Air quality is satisfactory. Ideal for outdoor activities.';
    if (aqi <= 100) return 'Acceptable air quality. Sensitive groups should limit prolonged outdoor exertion.';
    if (aqi <= 150) return 'Sensitive individuals may experience health effects.';
    if (aqi <= 200) return 'Everyone may begin to experience health effects.';
    return 'Health warnings of emergency conditions.';
  }

  List<String> _healthTips(int aqi) {
    if (aqi <= 50) {
      return [
        'Great day for outdoor activities',
        'Windows can be opened for fresh air',
        'No special precautions needed',
      ];
    }
    if (aqi <= 100) {
      return [
        'Sensitive groups should reduce prolonged exertion outdoors',
        'Consider wearing a mask if doing heavy outdoor exercise',
        'Indoor air quality is generally good',
      ];
    }
    return [
      'Wear a mask (N95/KN95) when outdoors',
      'Limit time outdoors, especially with children',
      'Keep windows closed and use air purifiers indoors',
      'Avoid vigorous outdoor activities',
    ];
  }
}

class _Pollutant {
  final String name;
  final double value;
  final double max;
  final String unit;
  final String description;

  const _Pollutant(
      this.name, this.value, this.max, this.unit, this.description);
}

class _PollutantRow extends StatelessWidget {
  final _Pollutant pollutant;

  const _PollutantRow({required this.pollutant});

  Color get _barColor {
    final ratio = pollutant.value / pollutant.max;
    if (ratio < 0.4) return Colors.green.shade500;
    if (ratio < 0.7) return Colors.orange.shade500;
    return Colors.red.shade500;
  }

  @override
  Widget build(BuildContext context) {
    final ratio = (pollutant.value / pollutant.max).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(pollutant.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 13)),
              Text(
                '${pollutant.value} ${pollutant.unit}',
                style: TextStyle(
                    color: _barColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(pollutant.description,
              style: const TextStyle(
                  color: AppTheme.textSecondary, fontSize: 11)),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ratio,
              backgroundColor: AppTheme.divider,
              valueColor: AlwaysStoppedAnimation<Color>(_barColor),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
