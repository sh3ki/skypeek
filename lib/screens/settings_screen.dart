import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';
import '../widgets/weather_card.dart';

class SettingsScreen extends StatelessWidget {
  final bool useCelsius;
  final ValueChanged<bool> onUnitToggled;
  final CityWeather currentCity;

  const SettingsScreen({super.key, required this.useCelsius, required this.onUnitToggled, required this.currentCity});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Settings', style: TextStyle(color: AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 24),

            // App info
            SurfaceCard(
              child: Row(
                children: [
                  const AppLogo(size: 44, showText: true),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.secondary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('v1.0', style: TextStyle(color: AppTheme.secondary, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Temperature unit
            const Text('Units', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SurfaceCard(
              child: Column(
                children: [
                  _UnitOption(
                    label: 'Celsius (°C)',
                    subtitle: 'Metric temperature',
                    isSelected: useCelsius,
                    onTap: () => onUnitToggled(true),
                  ),
                  const Divider(height: 1),
                  _UnitOption(
                    label: 'Fahrenheit (°F)',
                    subtitle: 'Imperial temperature',
                    isSelected: !useCelsius,
                    onTap: () => onUnitToggled(false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Current city info
            const Text('Current Location', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SurfaceCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppTheme.secondary.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.location_on_rounded, color: AppTheme.secondary, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentCity.city, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                      Text(currentCity.country, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                    ],
                  ),
                  const Spacer(),
                  Text(currentCity.timezone, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Preferences
            const Text('Preferences', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SurfaceCard(
              child: Column(
                children: [
                  _ToggleTile(icon: Icons.notifications_outlined, label: 'Weather Alerts', value: true),
                  const Divider(height: 1),
                  _ToggleTile(icon: Icons.dark_mode_outlined, label: 'Dark Mode', value: false),
                  const Divider(height: 1),
                  _ToggleTile(icon: Icons.gps_fixed_rounded, label: 'Auto Location', value: true),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // About
            const Text('About', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SurfaceCard(
              child: Column(
                children: [
                  _InfoRow(label: 'Data Source', value: 'SkyPeek API'),
                  const Divider(height: 1),
                  _InfoRow(label: 'Refresh Interval', value: '30 minutes'),
                  const Divider(height: 1),
                  _InfoRow(label: 'Cities Available', value: '5'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitOption extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _UnitOption({required this.label, required this.subtitle, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              color: isSelected ? AppTheme.secondary : AppTheme.textSecondary,
              size: 22,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                Text(subtitle, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;

  const _ToggleTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.textSecondary, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14))),
          Switch(value: value, onChanged: (_) {}, activeColor: AppTheme.secondary),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
          Text(value, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
