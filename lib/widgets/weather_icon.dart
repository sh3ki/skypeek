import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../theme/app_theme.dart';

class WeatherIcon extends StatelessWidget {
  final WeatherCondition condition;
  final double size;

  const WeatherIcon({
    super.key,
    required this.condition,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: _buildIconLayers(),
      ),
    );
  }

  List<Widget> _buildIconLayers() {
    switch (condition) {
      case WeatherCondition.sunny:
        return [
          Icon(Icons.wb_sunny_rounded, color: Colors.amber.shade400, size: size),
        ];
      case WeatherCondition.partlyCloudy:
        return [
          Positioned(
            top: 0,
            right: 0,
            child: Icon(Icons.wb_sunny_rounded,
                color: Colors.amber.shade300, size: size * 0.65),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Icon(Icons.cloud_rounded, color: Colors.white, size: size * 0.75),
          ),
        ];
      case WeatherCondition.cloudy:
        return [
          Icon(Icons.cloud_rounded, color: Colors.white70, size: size * 0.75),
          Positioned(
            left: size * 0.1,
            top: size * 0.1,
            child: Icon(Icons.cloud_rounded, color: Colors.white, size: size * 0.9),
          ),
        ];
      case WeatherCondition.rainy:
        return [
          Positioned(
            top: 0,
            child: Icon(Icons.cloud_rounded, color: Colors.white70, size: size * 0.75),
          ),
          Positioned(
            bottom: size * 0.05,
            child: Icon(Icons.grain_rounded, color: Colors.lightBlue.shade200, size: size * 0.55),
          ),
        ];
      case WeatherCondition.stormy:
        return [
          Positioned(
            top: 0,
            child: Icon(Icons.cloud_rounded, color: Colors.grey.shade300, size: size * 0.75),
          ),
          Positioned(
            bottom: size * 0.05,
            child: Icon(Icons.bolt_rounded, color: Colors.yellow.shade300, size: size * 0.6),
          ),
        ];
      case WeatherCondition.snowy:
        return [
          Positioned(
            top: 0,
            child: Icon(Icons.cloud_rounded, color: Colors.white, size: size * 0.75),
          ),
          Positioned(
            bottom: size * 0.05,
            child: Icon(Icons.ac_unit_rounded, color: Colors.lightBlue.shade100, size: size * 0.5),
          ),
        ];
      case WeatherCondition.foggy:
        return [
          Icon(Icons.waves_rounded, color: Colors.white54, size: size * 0.9),
        ];
      case WeatherCondition.windy:
        return [
          Icon(Icons.air_rounded, color: AppTheme.primary.withOpacity(0.7), size: size),
        ];
    }
  }
}

class WeatherConditionBackground extends StatelessWidget {
  final WeatherCondition condition;
  final Widget child;
  final BorderRadius? borderRadius;

  const WeatherConditionBackground({
    super.key,
    required this.condition,
    required this.child,
    this.borderRadius,
  });

  LinearGradient get _gradient {
    switch (condition) {
      case WeatherCondition.sunny:
        return AppTheme.sunnyGradient;
      case WeatherCondition.partlyCloudy:
        return const LinearGradient(
          colors: [Color(0xFF38BDF8), Color(0xFF0EA5E9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.cloudy:
        return AppTheme.cloudyGradient;
      case WeatherCondition.rainy:
      case WeatherCondition.stormy:
        return AppTheme.rainyGradient;
      case WeatherCondition.snowy:
        return const LinearGradient(
          colors: [Color(0xFF93C5FD), Color(0xFF60A5FA)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.foggy:
        return const LinearGradient(
          colors: [Color(0xFF94A3B8), Color(0xFF64748B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.windy:
        return const LinearGradient(
          colors: [Color(0xFF38BDF8), Color(0xFF0284C7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: _gradient,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
