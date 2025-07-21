import 'package:flutter/material.dart';
//import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:weather_icons/weather_icons.dart';
class Globals {

  static IconData getWeatherIcon(int iconCode) {
    switch (iconCode) {
      case 1:
        return WeatherIcons.day_sunny;
      case 2:
        return WeatherIcons.day_sunny_overcast;
      case 3:
        return WeatherIcons.day_cloudy;
      case 4:
        return WeatherIcons.day_sunny_overcast;
      case 5:
      case 6:
        return WeatherIcons.day_fog;
      case 7:
      case 8:
      case 9:
      case 10:
      case 11:
        return WeatherIcons.day_rain;
      case 12:
      case 13:
      case 19:
      case 20:
        return WeatherIcons.day_sleet;
      case 15:
      case 16:
        return WeatherIcons.day_snow;
      case 17:
      case 18:
        return WeatherIcons.day_rain_wind;
      case 21:
      case 22:
        return WeatherIcons.day_snow_wind;
      case 23:
        return WeatherIcons.day_lightning;
      case 24:
        return WeatherIcons.day_hail;
      case 25:
        return WeatherIcons.day_thunderstorm;
      case 26:
        return WeatherIcons.thermometer_exterior;
      case 27:
        return WeatherIcons.storm_showers;

      default:
        return WeatherIcons.day_sunny;
    }
  }

  static String? getWeatherStatus(int iconCode) {
    switch (iconCode) {
      case 1:
        return 'Clear';
      case 2:
        return 'Fair';
      case 3:
        return 'Cloudy';
      case 4:
        return 'Overcast';
      case 5:
        return 'Fog';
      case 6:
        return 'Freezing Fog';
      case 7:
        return 'Light Rain';
      case 8:
        return 'Rain';
      case 9:
        return 'Heavy Rain';
      case 10:
        return 'Freezing Rain';
      case 11:
        return 'Heavy Freezing Rain';
      case 12:
        return 'Sleet';
      case 13:
        return 'Sleet';

      case 114:
        return 'Light Snowfall';
      case 15:
        return 'Snowfall';
      case 16:
        return 'Heavy Snowfall';
      case 17:
        return 'Rain Shower';
      case 18:
        return 'Heavy Rain Shower';
      case 19:
        return 'Sleet Shower';
      case 20:
        return 'Heavy Sleet Shower';
      case 21:
        return 'Snow Shower';
      case 22:
        return 'Heavy Snow Shower';
      case 23:
        return 'Lightning';
      case 24:
        return 'Hail';
      case 25:
        return 'Thunderstorm';
      case 26:
        return 'Heavy Thunderstorm';
      case 27:
        return 'Storm';
    }
  }
}