import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../theme/app_theme.dart';

class WeatherIcon extends StatelessWidget {
  final WeatherCondition condition;
  final double size;
  final Color? color;

  const WeatherIcon({super.key, required this.condition, this.size = 48, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppTheme.conditionColor(condition.label);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: c.withOpacity(0.12),
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(condition.icon, color: c, size: size * 0.55),
    );
  }
}

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? unit;

  const MetricCard({super.key, required this.icon, required this.label, required this.value, this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.secondary, size: 20),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
              if (unit != null) ...[
                const SizedBox(width: 2),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(unit!, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class HourlyCard extends StatelessWidget {
  final String hour;
  final String temp;
  final WeatherCondition condition;
  final bool isNow;

  const HourlyCard({super.key, required this.hour, required this.temp, required this.condition, this.isNow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isNow ? AppTheme.primary : AppTheme.cardBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: isNow ? null : AppTheme.cardShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(hour, style: TextStyle(color: isNow ? Colors.white70 : AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Icon(condition.icon, color: isNow ? Colors.white : AppTheme.conditionColor(condition.label), size: 22),
          const SizedBox(height: 8),
          Text(temp, style: TextStyle(color: isNow ? Colors.white : AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class SurfaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const SurfaceCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: child,
    );
  }
}
