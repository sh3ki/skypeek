import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';
import '../widgets/weather_card.dart';

class SettingsScreen extends StatefulWidget {
  final bool useCelsius;
  final void Function(bool) onUnitToggle;

  const SettingsScreen({
    super.key,
    required this.useCelsius,
    required this.onUnitToggle,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _useCelsius;
  bool _notifications = true;
  bool _weatherAlerts = true;
  bool _dailySummary = false;
  bool _locationServices = true;
  String _windUnit = 'km/h';
  String _refreshInterval = 'Every 30 min';

  @override
  void initState() {
    super.initState();
    _useCelsius = widget.useCelsius;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileCard(),
              const SizedBox(height: 20),
              _buildSectionLabel('Units'),
              _buildUnitsSection(),
              const SizedBox(height: 20),
              _buildSectionLabel('Notifications'),
              _buildNotificationsSection(),
              const SizedBox(height: 20),
              _buildSectionLabel('Location & Data'),
              _buildLocationSection(),
              const SizedBox(height: 20),
              _buildSectionLabel('About'),
              _buildAboutSection(),
              const SizedBox(height: 32),
              Center(child: AppLogo(size: 36, lightText: false)),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'SkyPeek v1.0.0 • Portfolio Demo',
                  style: const TextStyle(
                      color: AppTheme.textSecondary, fontSize: 11),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('AR',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 22)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Alex Rivera',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text('New York • USA',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 13)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    _profileChip('5 Cities'),
                    _profileChip('Pro User'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Text(label,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              )),
    );
  }

  Widget _buildUnitsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SurfaceCard(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Temperature',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    Text(_useCelsius ? 'Celsius (°C)' : 'Fahrenheit (°F)',
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12)),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: Row(
                    children: [
                      _UnitBtn(
                          label: '°C',
                          selected: _useCelsius,
                          onTap: () {
                            setState(() => _useCelsius = true);
                            widget.onUnitToggle(true);
                          }),
                      _UnitBtn(
                          label: '°F',
                          selected: !_useCelsius,
                          onTap: () {
                            setState(() => _useCelsius = false);
                            widget.onUnitToggle(false);
                          }),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 28, color: AppTheme.divider),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Wind Speed',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    Text('Current unit',
                        style: TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12)),
                  ],
                ),
                DropdownButton<String>(
                  value: _windUnit,
                  underline: const SizedBox(),
                  style: const TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13),
                  items: ['km/h', 'm/s', 'mph', 'knots']
                      .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                      .toList(),
                  onChanged: (v) => setState(() => _windUnit = v!),
                ),
              ],
            ),
            const Divider(height: 28, color: AppTheme.divider),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Refresh Interval',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    Text('Auto update frequency',
                        style: TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12)),
                  ],
                ),
                DropdownButton<String>(
                  value: _refreshInterval,
                  underline: const SizedBox(),
                  style: const TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13),
                  items: ['Every 15 min', 'Every 30 min', 'Every hour', 'Manual']
                      .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                      .toList(),
                  onChanged: (v) => setState(() => _refreshInterval = v!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SurfaceCard(
        child: Column(
          children: [
            _ToggleRow(
              icon: Icons.notifications_active_rounded,
              iconColor: AppTheme.primary,
              label: 'Notifications',
              subtitle: 'Enable push notifications',
              value: _notifications,
              onChanged: (v) => setState(() => _notifications = v),
            ),
            const Divider(height: 20, color: AppTheme.divider),
            _ToggleRow(
              icon: Icons.warning_amber_rounded,
              iconColor: Colors.orange,
              label: 'Severe Weather Alerts',
              subtitle: 'Storms, heavy rain, etc.',
              value: _weatherAlerts,
              onChanged: (v) => setState(() => _weatherAlerts = v),
            ),
            const Divider(height: 20, color: AppTheme.divider),
            _ToggleRow(
              icon: Icons.wb_sunny_rounded,
              iconColor: Colors.amber,
              label: 'Daily Summary',
              subtitle: 'Morning weather briefing',
              value: _dailySummary,
              onChanged: (v) => setState(() => _dailySummary = v),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SurfaceCard(
        child: Column(
          children: [
            _ToggleRow(
              icon: Icons.location_on_rounded,
              iconColor: Colors.red,
              label: 'Location Services',
              subtitle: 'Detect current city',
              value: _locationServices,
              onChanged: (v) => setState(() => _locationServices = v),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SurfaceCard(
        child: Column(
          children: [
            _InfoRow(icon: Icons.code_rounded, label: 'Version', value: 'v1.0.0'),
            const Divider(height: 20, color: AppTheme.divider),
            _InfoRow(
                icon: Icons.cloud_queue_rounded,
                label: 'Data Source',
                value: 'Mock Data'),
            const Divider(height: 20, color: AppTheme.divider),
            _InfoRow(
                icon: Icons.flutter_dash_rounded,
                label: 'Built with',
                value: 'Flutter 3.24'),
            const Divider(height: 20, color: AppTheme.divider),
            _InfoRow(
                icon: Icons.work_rounded,
                label: 'Category',
                value: 'Portfolio App'),
          ],
        ),
      ),
    );
  }
}

class _UnitBtn extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _UnitBtn(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppTheme.textSecondary,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String subtitle;
  final bool value;
  final void Function(bool) onChanged;

  const _ToggleRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14)),
              Text(subtitle,
                  style: const TextStyle(
                      color: AppTheme.textSecondary, fontSize: 11)),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.primary,
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.textSecondary, size: 18),
        const SizedBox(width: 10),
        Text(label,
            style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 13)),
      ],
    );
  }
}
