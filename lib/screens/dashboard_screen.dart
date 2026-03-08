import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/weather_model.dart';
import '../widgets/weather_icon.dart';
import '../widgets/weather_card.dart';
import 'hourly_forecast_screen.dart';
import 'air_quality_screen.dart';

class DashboardScreen extends StatelessWidget {
  final CityWeather city;
  final bool useCelsius;

  const DashboardScreen({
    super.key,
    required this.city,
    required this.useCelsius,
  });

  String _temp(double c) {
    if (useCelsius) return '${c.round()}°C';
    return '${(c * 9 / 5 + 32).round()}°F';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeatherConditionBackground(
        condition: city.condition,
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              _buildHeader(context),
              _buildHeroTemp(),
              _buildHourlySection(context),
              _buildMetricsGrid(context),
              _buildSunriseSection(),
              _buildAirQualityTeaser(context),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded,
                        color: Colors.white70, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      city.city,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        city.country,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  city.timezone,
                  style: const TextStyle(
                      color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.notifications_none_rounded,
                  color: Colors.white, size: 22),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroTemp() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    useCelsius
                        ? '${city.tempC.round()}°'
                        : '${city.tempF.round()}°',
                    style: const TextStyle(
                      fontSize: 88,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    city.condition.label,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Feels like ${_temp(city.feelsLikeC)}',
                    style: const TextStyle(
                        color: Colors.white60, fontSize: 13),
                  ),
                ],
              ),
            ),
            WeatherIcon(condition: city.condition, size: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlySection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HourlyForecastScreen(
                        city: city,
                        useCelsius: useCelsius,
                      ),
                    ),
                  ),
                  child: const Text(
                    'See all',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 118,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemCount: city.hourly.length > 12 ? 12 : city.hourly.length,
              itemBuilder: (context, i) {
                final h = city.hourly[i];
                return HourlyCard(
                  hour: h.hour,
                  temp: useCelsius
                      ? '${h.tempC.round()}°'
                      : '${h.tempF.round()}°',
                  icon: WeatherIcon(condition: h.condition, size: 30),
                  isNow: i == 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: AnimationLimiter(
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.6,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 300),
              childAnimationBuilder: (w) => SlideAnimation(
                verticalOffset: 20,
                child: FadeInAnimation(child: w),
              ),
              children: [
                MetricCard(
                  icon: Icons.water_drop_rounded,
                  label: 'Humidity',
                  value: '${city.humidity}',
                  unit: '%',
                  iconColor: Colors.lightBlue.shade200,
                ),
                MetricCard(
                  icon: Icons.air_rounded,
                  label: 'Wind',
                  value: '${city.windSpeedKmh.round()}',
                  unit: 'km/h',
                  iconColor: Colors.white70,
                ),
                MetricCard(
                  icon: Icons.wb_sunny_outlined,
                  label: 'UV Index',
                  value: '${city.uvIndex}',
                  unit: _uvLabel(city.uvIndex),
                  iconColor: Colors.amber.shade300,
                ),
                MetricCard(
                  icon: Icons.compress_rounded,
                  label: 'Pressure',
                  value: '${city.pressure}',
                  unit: 'hPa',
                  iconColor: Colors.purple.shade200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _uvLabel(int uv) {
    if (uv <= 2) return 'Low';
    if (uv <= 5) return 'Mod';
    if (uv <= 7) return 'High';
    if (uv <= 10) return 'V.High';
    return 'Extreme';
  }

  Widget _buildSunriseSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.wb_twilight_rounded,
                        color: Colors.amber, size: 32),
                    const SizedBox(height: 8),
                    const Text('Sunrise',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                      city.sunrise,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.nightlight_round,
                        color: Colors.orange, size: 32),
                    const SizedBox(height: 8),
                    const Text('Sunset',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                      city.sunset,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAirQualityTeaser(BuildContext context) {
    final aq = city.airQuality;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AirQualityScreen(city: city),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.25)),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Air Quality',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          '${aq.aqi}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _aqiColor(aq.aqi).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: _aqiColor(aq.aqi).withOpacity(0.6)),
                          ),
                          child: Text(
                            aq.aqiLabel,
                            style: TextStyle(
                                color: _aqiColor(aq.aqi),
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.white60, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _aqiColor(int aqi) {
    if (aqi <= 50) return Colors.green.shade300;
    if (aqi <= 100) return Colors.yellow.shade300;
    if (aqi <= 150) return Colors.orange.shade300;
    return Colors.red.shade300;
  }
}
