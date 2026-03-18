import 'package:flutter/material.dart';

enum WeatherCondition {
  sunny,
  partlyCloudy,
  cloudy,
  rainy,
  stormy,
  snowy,
  foggy,
  windy,
}

extension WeatherConditionExt on WeatherCondition {
  String get label {
    switch (this) {
      case WeatherCondition.sunny: return 'Sunny';
      case WeatherCondition.partlyCloudy: return 'Partly Cloudy';
      case WeatherCondition.cloudy: return 'Cloudy';
      case WeatherCondition.rainy: return 'Rainy';
      case WeatherCondition.stormy: return 'Stormy';
      case WeatherCondition.snowy: return 'Snowy';
      case WeatherCondition.foggy: return 'Foggy';
      case WeatherCondition.windy: return 'Windy';
    }
  }

  IconData get icon {
    switch (this) {
      case WeatherCondition.sunny: return Icons.wb_sunny_rounded;
      case WeatherCondition.partlyCloudy: return Icons.cloud_queue_rounded;
      case WeatherCondition.cloudy: return Icons.cloud_rounded;
      case WeatherCondition.rainy: return Icons.grain_rounded;
      case WeatherCondition.stormy: return Icons.thunderstorm_rounded;
      case WeatherCondition.snowy: return Icons.ac_unit_rounded;
      case WeatherCondition.foggy: return Icons.blur_on_rounded;
      case WeatherCondition.windy: return Icons.air_rounded;
    }
  }
}

class HourlyForecast {
  final String hour;
  final double tempC;
  final WeatherCondition condition;
  final int rainChance;

  const HourlyForecast({
    required this.hour,
    required this.tempC,
    required this.condition,
    required this.rainChance,
  });

  double get tempF => tempC * 9 / 5 + 32;
}

class DailyForecast {
  final String day;
  final double highC;
  final double lowC;
  final WeatherCondition condition;
  final int rainChance;
  final int humidity;

  const DailyForecast({
    required this.day,
    required this.highC,
    required this.lowC,
    required this.condition,
    required this.rainChance,
    required this.humidity,
  });

  double get highF => highC * 9 / 5 + 32;
  double get lowF => lowC * 9 / 5 + 32;
}

class AirQualityData {
  final int aqi;
  final double pm25;
  final double pm10;
  final double no2;
  final double o3;
  final double co;

  const AirQualityData({
    required this.aqi,
    required this.pm25,
    required this.pm10,
    required this.no2,
    required this.o3,
    required this.co,
  });

  String get aqiLabel {
    if (aqi <= 50) return 'Good';
    if (aqi <= 100) return 'Moderate';
    if (aqi <= 150) return 'Unhealthy for Sensitive';
    if (aqi <= 200) return 'Unhealthy';
    return 'Very Unhealthy';
  }
}

class CityWeather {
  final String city;
  final String country;
  final String timezone;
  final double tempC;
  final double feelsLikeC;
  final int humidity;
  final double windSpeedKmh;
  final int uvIndex;
  final int pressure;
  final int visibility;
  final WeatherCondition condition;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;
  final AirQualityData airQuality;
  final String sunrise;
  final String sunset;

  const CityWeather({
    required this.city,
    required this.country,
    required this.timezone,
    required this.tempC,
    required this.feelsLikeC,
    required this.humidity,
    required this.windSpeedKmh,
    required this.uvIndex,
    required this.pressure,
    required this.visibility,
    required this.condition,
    required this.hourly,
    required this.daily,
    required this.airQuality,
    required this.sunrise,
    required this.sunset,
  });

  double get tempF => tempC * 9 / 5 + 32;
  double get feelsLikeF => feelsLikeC * 9 / 5 + 32;
}
