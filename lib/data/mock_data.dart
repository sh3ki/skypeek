import '../models/weather_model.dart';

class MockData {
  static List<CityWeather> get cities => [
        newYork,
        london,
        tokyo,
        paris,
        sydney,
      ];

  static CityWeather get defaultCity => newYork;

  // --------------- NEW YORK ---------------
  static CityWeather get newYork => CityWeather(
        city: 'New York',
        country: 'US',
        timezone: 'EST',
        tempC: 22,
        feelsLikeC: 20,
        humidity: 55,
        windSpeedKmh: 14,
        uvIndex: 6,
        pressure: 1012,
        visibility: 16,
        condition: WeatherCondition.sunny,
        sunrise: '6:23 AM',
        sunset: '7:51 PM',
        airQuality: const AirQualityData(
          aqi: 42,
          pm25: 8.2,
          pm10: 18.5,
          no2: 22.1,
          o3: 48.3,
          co: 0.4,
        ),
        hourly: _newYorkHourly,
        daily: _newYorkDaily,
      );

  static final List<HourlyForecast> _newYorkHourly = [
    const HourlyForecast(hour: '12 AM', tempC: 17, condition: WeatherCondition.cloudy, rainChance: 10),
    const HourlyForecast(hour: '1 AM', tempC: 16, condition: WeatherCondition.cloudy, rainChance: 12),
    const HourlyForecast(hour: '2 AM', tempC: 15, condition: WeatherCondition.cloudy, rainChance: 15),
    const HourlyForecast(hour: '3 AM', tempC: 15, condition: WeatherCondition.cloudy, rainChance: 18),
    const HourlyForecast(hour: '4 AM', tempC: 14, condition: WeatherCondition.partlyCloudy, rainChance: 10),
    const HourlyForecast(hour: '5 AM', tempC: 14, condition: WeatherCondition.partlyCloudy, rainChance: 8),
    const HourlyForecast(hour: '6 AM', tempC: 15, condition: WeatherCondition.sunny, rainChance: 5),
    const HourlyForecast(hour: '7 AM', tempC: 16, condition: WeatherCondition.sunny, rainChance: 3),
    const HourlyForecast(hour: '8 AM', tempC: 18, condition: WeatherCondition.sunny, rainChance: 2),
    const HourlyForecast(hour: '9 AM', tempC: 19, condition: WeatherCondition.sunny, rainChance: 2),
    const HourlyForecast(hour: '10 AM', tempC: 20, condition: WeatherCondition.sunny, rainChance: 5),
    const HourlyForecast(hour: '11 AM', tempC: 21, condition: WeatherCondition.sunny, rainChance: 5),
    const HourlyForecast(hour: '12 PM', tempC: 22, condition: WeatherCondition.sunny, rainChance: 5),
    const HourlyForecast(hour: '1 PM', tempC: 23, condition: WeatherCondition.sunny, rainChance: 8),
    const HourlyForecast(hour: '2 PM', tempC: 24, condition: WeatherCondition.partlyCloudy, rainChance: 10),
    const HourlyForecast(hour: '3 PM', tempC: 23, condition: WeatherCondition.partlyCloudy, rainChance: 12),
    const HourlyForecast(hour: '4 PM', tempC: 22, condition: WeatherCondition.partlyCloudy, rainChance: 15),
    const HourlyForecast(hour: '5 PM', tempC: 21, condition: WeatherCondition.cloudy, rainChance: 20),
    const HourlyForecast(hour: '6 PM', tempC: 20, condition: WeatherCondition.cloudy, rainChance: 25),
    const HourlyForecast(hour: '7 PM', tempC: 19, condition: WeatherCondition.cloudy, rainChance: 22),
    const HourlyForecast(hour: '8 PM', tempC: 18, condition: WeatherCondition.partlyCloudy, rainChance: 15),
    const HourlyForecast(hour: '9 PM', tempC: 18, condition: WeatherCondition.partlyCloudy, rainChance: 10),
    const HourlyForecast(hour: '10 PM', tempC: 17, condition: WeatherCondition.cloudy, rainChance: 8),
    const HourlyForecast(hour: '11 PM', tempC: 17, condition: WeatherCondition.cloudy, rainChance: 10),
  ];

  static const List<DailyForecast> _newYorkDaily = [
    DailyForecast(day: 'Today', highC: 24, lowC: 14, condition: WeatherCondition.sunny, rainChance: 5, humidity: 55),
    DailyForecast(day: 'Tue', highC: 22, lowC: 13, condition: WeatherCondition.partlyCloudy, rainChance: 15, humidity: 60),
    DailyForecast(day: 'Wed', highC: 18, lowC: 11, condition: WeatherCondition.rainy, rainChance: 75, humidity: 80),
    DailyForecast(day: 'Thu', highC: 16, lowC: 10, condition: WeatherCondition.rainy, rainChance: 80, humidity: 85),
    DailyForecast(day: 'Fri', highC: 20, lowC: 12, condition: WeatherCondition.partlyCloudy, rainChance: 20, humidity: 65),
    DailyForecast(day: 'Sat', highC: 25, lowC: 15, condition: WeatherCondition.sunny, rainChance: 5, humidity: 50),
    DailyForecast(day: 'Sun', highC: 26, lowC: 16, condition: WeatherCondition.sunny, rainChance: 5, humidity: 48),
  ];

  // --------------- LONDON ---------------
  static CityWeather get london => CityWeather(
        city: 'London',
        country: 'UK',
        timezone: 'GMT',
        tempC: 14,
        feelsLikeC: 12,
        humidity: 78,
        windSpeedKmh: 22,
        uvIndex: 2,
        pressure: 1008,
        visibility: 10,
        condition: WeatherCondition.cloudy,
        sunrise: '5:58 AM',
        sunset: '8:32 PM',
        airQuality: const AirQualityData(
          aqi: 65,
          pm25: 14.5,
          pm10: 28.2,
          no2: 38.4,
          o3: 42.1,
          co: 0.7,
        ),
        hourly: _londonHourly,
        daily: _londonDaily,
      );

  static final List<HourlyForecast> _londonHourly = [
    const HourlyForecast(hour: '12 AM', tempC: 11, condition: WeatherCondition.cloudy, rainChance: 30),
    const HourlyForecast(hour: '3 AM', tempC: 10, condition: WeatherCondition.cloudy, rainChance: 35),
    const HourlyForecast(hour: '6 AM', tempC: 10, condition: WeatherCondition.rainy, rainChance: 60),
    const HourlyForecast(hour: '9 AM', tempC: 12, condition: WeatherCondition.rainy, rainChance: 70),
    const HourlyForecast(hour: '12 PM', tempC: 14, condition: WeatherCondition.cloudy, rainChance: 40),
    const HourlyForecast(hour: '3 PM', tempC: 15, condition: WeatherCondition.partlyCloudy, rainChance: 25),
    const HourlyForecast(hour: '6 PM', tempC: 14, condition: WeatherCondition.cloudy, rainChance: 35),
    const HourlyForecast(hour: '9 PM', tempC: 12, condition: WeatherCondition.cloudy, rainChance: 30),
  ];

  static const List<DailyForecast> _londonDaily = [
    DailyForecast(day: 'Today', highC: 15, lowC: 10, condition: WeatherCondition.cloudy, rainChance: 40, humidity: 78),
    DailyForecast(day: 'Tue', highC: 13, lowC: 9, condition: WeatherCondition.rainy, rainChance: 80, humidity: 88),
    DailyForecast(day: 'Wed', highC: 12, lowC: 8, condition: WeatherCondition.rainy, rainChance: 85, humidity: 90),
    DailyForecast(day: 'Thu', highC: 14, lowC: 9, condition: WeatherCondition.partlyCloudy, rainChance: 30, humidity: 72),
    DailyForecast(day: 'Fri', highC: 16, lowC: 10, condition: WeatherCondition.partlyCloudy, rainChance: 20, humidity: 65),
    DailyForecast(day: 'Sat', highC: 18, lowC: 11, condition: WeatherCondition.sunny, rainChance: 10, humidity: 60),
    DailyForecast(day: 'Sun', highC: 16, lowC: 10, condition: WeatherCondition.cloudy, rainChance: 35, humidity: 70),
  ];

  // --------------- TOKYO ---------------
  static CityWeather get tokyo => CityWeather(
        city: 'Tokyo',
        country: 'JP',
        timezone: 'JST',
        tempC: 18,
        feelsLikeC: 17,
        humidity: 62,
        windSpeedKmh: 8,
        uvIndex: 4,
        pressure: 1018,
        visibility: 20,
        condition: WeatherCondition.partlyCloudy,
        sunrise: '4:48 AM',
        sunset: '6:50 PM',
        airQuality: const AirQualityData(
          aqi: 55,
          pm25: 11.2,
          pm10: 22.8,
          no2: 30.5,
          o3: 55.2,
          co: 0.5,
        ),
        hourly: _tokyoHourly,
        daily: _tokyoDaily,
      );

  static final List<HourlyForecast> _tokyoHourly = [
    const HourlyForecast(hour: '12 AM', tempC: 14, condition: WeatherCondition.cloudy, rainChance: 20),
    const HourlyForecast(hour: '3 AM', tempC: 13, condition: WeatherCondition.partlyCloudy, rainChance: 15),
    const HourlyForecast(hour: '6 AM', tempC: 14, condition: WeatherCondition.sunny, rainChance: 5),
    const HourlyForecast(hour: '9 AM', tempC: 16, condition: WeatherCondition.partlyCloudy, rainChance: 10),
    const HourlyForecast(hour: '12 PM', tempC: 18, condition: WeatherCondition.partlyCloudy, rainChance: 15),
    const HourlyForecast(hour: '3 PM', tempC: 19, condition: WeatherCondition.partlyCloudy, rainChance: 18),
    const HourlyForecast(hour: '6 PM', tempC: 18, condition: WeatherCondition.cloudy, rainChance: 25),
    const HourlyForecast(hour: '9 PM', tempC: 16, condition: WeatherCondition.cloudy, rainChance: 22),
  ];

  static const List<DailyForecast> _tokyoDaily = [
    DailyForecast(day: 'Today', highC: 19, lowC: 13, condition: WeatherCondition.partlyCloudy, rainChance: 15, humidity: 62),
    DailyForecast(day: 'Tue', highC: 22, lowC: 14, condition: WeatherCondition.sunny, rainChance: 5, humidity: 55),
    DailyForecast(day: 'Wed', highC: 24, lowC: 15, condition: WeatherCondition.sunny, rainChance: 5, humidity: 52),
    DailyForecast(day: 'Thu', highC: 20, lowC: 13, condition: WeatherCondition.rainy, rainChance: 70, humidity: 80),
    DailyForecast(day: 'Fri', highC: 18, lowC: 12, condition: WeatherCondition.rainy, rainChance: 65, humidity: 82),
    DailyForecast(day: 'Sat', highC: 21, lowC: 14, condition: WeatherCondition.partlyCloudy, rainChance: 20, humidity: 65),
    DailyForecast(day: 'Sun', highC: 23, lowC: 15, condition: WeatherCondition.sunny, rainChance: 8, humidity: 58),
  ];

  // --------------- PARIS ---------------
  static CityWeather get paris => CityWeather(
        city: 'Paris',
        country: 'FR',
        timezone: 'CET',
        tempC: 13,
        feelsLikeC: 11,
        humidity: 82,
        windSpeedKmh: 18,
        uvIndex: 1,
        pressure: 1005,
        visibility: 8,
        condition: WeatherCondition.rainy,
        sunrise: '6:05 AM',
        sunset: '9:05 PM',
        airQuality: const AirQualityData(
          aqi: 72,
          pm25: 16.8,
          pm10: 32.4,
          no2: 44.2,
          o3: 38.5,
          co: 0.9,
        ),
        hourly: _parisHourly,
        daily: _parisDaily,
      );

  static final List<HourlyForecast> _parisHourly = [
    const HourlyForecast(hour: '12 AM', tempC: 10, condition: WeatherCondition.rainy, rainChance: 70),
    const HourlyForecast(hour: '3 AM', tempC: 9, condition: WeatherCondition.rainy, rainChance: 75),
    const HourlyForecast(hour: '6 AM', tempC: 9, condition: WeatherCondition.rainy, rainChance: 80),
    const HourlyForecast(hour: '9 AM', tempC: 11, condition: WeatherCondition.rainy, rainChance: 78),
    const HourlyForecast(hour: '12 PM', tempC: 13, condition: WeatherCondition.cloudy, rainChance: 50),
    const HourlyForecast(hour: '3 PM', tempC: 14, condition: WeatherCondition.partlyCloudy, rainChance: 30),
    const HourlyForecast(hour: '6 PM', tempC: 13, condition: WeatherCondition.cloudy, rainChance: 40),
    const HourlyForecast(hour: '9 PM', tempC: 11, condition: WeatherCondition.rainy, rainChance: 65),
  ];

  static const List<DailyForecast> _parisDaily = [
    DailyForecast(day: 'Today', highC: 14, lowC: 9, condition: WeatherCondition.rainy, rainChance: 80, humidity: 82),
    DailyForecast(day: 'Tue', highC: 15, lowC: 10, condition: WeatherCondition.cloudy, rainChance: 40, humidity: 74),
    DailyForecast(day: 'Wed', highC: 17, lowC: 11, condition: WeatherCondition.partlyCloudy, rainChance: 20, humidity: 65),
    DailyForecast(day: 'Thu', highC: 19, lowC: 12, condition: WeatherCondition.sunny, rainChance: 8, humidity: 58),
    DailyForecast(day: 'Fri', highC: 18, lowC: 11, condition: WeatherCondition.partlyCloudy, rainChance: 25, humidity: 68),
    DailyForecast(day: 'Sat', highC: 16, lowC: 10, condition: WeatherCondition.rainy, rainChance: 65, humidity: 78),
    DailyForecast(day: 'Sun', highC: 14, lowC: 9, condition: WeatherCondition.rainy, rainChance: 75, humidity: 85),
  ];

  // --------------- SYDNEY ---------------
  static CityWeather get sydney => CityWeather(
        city: 'Sydney',
        country: 'AU',
        timezone: 'AEST',
        tempC: 27,
        feelsLikeC: 28,
        humidity: 48,
        windSpeedKmh: 12,
        uvIndex: 9,
        pressure: 1020,
        visibility: 25,
        condition: WeatherCondition.sunny,
        sunrise: '7:05 AM',
        sunset: '5:05 PM',
        airQuality: const AirQualityData(
          aqi: 28,
          pm25: 5.4,
          pm10: 12.8,
          no2: 16.2,
          o3: 38.0,
          co: 0.3,
        ),
        hourly: _sydneyHourly,
        daily: _sydneyDaily,
      );

  static final List<HourlyForecast> _sydneyHourly = [
    const HourlyForecast(hour: '12 AM', tempC: 22, condition: WeatherCondition.partlyCloudy, rainChance: 5),
    const HourlyForecast(hour: '3 AM', tempC: 20, condition: WeatherCondition.cloudy, rainChance: 8),
    const HourlyForecast(hour: '6 AM', tempC: 19, condition: WeatherCondition.sunny, rainChance: 3),
    const HourlyForecast(hour: '9 AM', tempC: 23, condition: WeatherCondition.sunny, rainChance: 2),
    const HourlyForecast(hour: '12 PM', tempC: 27, condition: WeatherCondition.sunny, rainChance: 2),
    const HourlyForecast(hour: '3 PM', tempC: 28, condition: WeatherCondition.sunny, rainChance: 5),
    const HourlyForecast(hour: '6 PM', tempC: 25, condition: WeatherCondition.partlyCloudy, rainChance: 8),
    const HourlyForecast(hour: '9 PM', tempC: 23, condition: WeatherCondition.partlyCloudy, rainChance: 5),
  ];

  static const List<DailyForecast> _sydneyDaily = [
    DailyForecast(day: 'Today', highC: 28, lowC: 19, condition: WeatherCondition.sunny, rainChance: 5, humidity: 48),
    DailyForecast(day: 'Tue', highC: 30, lowC: 20, condition: WeatherCondition.sunny, rainChance: 3, humidity: 44),
    DailyForecast(day: 'Wed', highC: 29, lowC: 21, condition: WeatherCondition.partlyCloudy, rainChance: 10, humidity: 50),
    DailyForecast(day: 'Thu', highC: 26, lowC: 19, condition: WeatherCondition.cloudy, rainChance: 25, humidity: 62),
    DailyForecast(day: 'Fri', highC: 24, lowC: 17, condition: WeatherCondition.rainy, rainChance: 60, humidity: 75),
    DailyForecast(day: 'Sat', highC: 27, lowC: 18, condition: WeatherCondition.partlyCloudy, rainChance: 15, humidity: 55),
    DailyForecast(day: 'Sun', highC: 29, lowC: 20, condition: WeatherCondition.sunny, rainChance: 5, humidity: 50),
  ];
}
