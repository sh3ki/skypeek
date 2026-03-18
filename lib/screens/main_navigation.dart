import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/weather_data.dart';
import '../models/weather_model.dart';
import 'dashboard_screen.dart';
import 'hourly_forecast_screen.dart';
import 'search_city_screen.dart';
import 'settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  int _selectedCityIndex = 0;
  bool _useCelsius = true;

  CityWeather get _currentCity => WeatherData.cities[_selectedCityIndex];

  void _onCityChanged(int index) {
    setState(() => _selectedCityIndex = index);
  }

  void _onUnitToggled(bool celsius) {
    setState(() => _useCelsius = celsius);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(city: _currentCity, useCelsius: _useCelsius),
      HourlyForecastScreen(city: _currentCity, useCelsius: _useCelsius),
      SearchCityScreen(
        cities: WeatherData.cities,
        selectedIndex: _selectedCityIndex,
        useCelsius: _useCelsius,
        onCitySelected: _onCityChanged,
      ),
      SettingsScreen(
        useCelsius: _useCelsius,
        onUnitToggled: _onUnitToggled,
        currentCity: _currentCity,
      ),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        backgroundColor: AppTheme.cardBg,
        indicatorColor: AppTheme.secondary.withOpacity(0.12),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.wb_sunny_outlined), selectedIcon: Icon(Icons.wb_sunny_rounded), label: 'Today'),
          NavigationDestination(icon: Icon(Icons.schedule_outlined), selectedIcon: Icon(Icons.schedule_rounded), label: 'Forecast'),
          NavigationDestination(icon: Icon(Icons.location_city_outlined), selectedIcon: Icon(Icons.location_city_rounded), label: 'Cities'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }
}
