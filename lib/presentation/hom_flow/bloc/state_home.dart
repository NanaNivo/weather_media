import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/models/weather_hourly_daily_model.dart';
import 'package:weather/core/models/weather_meta_model.dart';

enum WeatherStatus {
  initial,
  loading,
  locationLoaded,
  stationsLoaded,
  weatherLoaded,
  error
}

class HomeState extends Equatable {
  final WeatherStatus status;
  final Position? position;
  final WeatherMeta? stations;
  final WeatherDaily? dailyData;
  final WeatherHourly? hourlyData;
  final String? errorMessage;
  final bool isLoading;

  const HomeState({
    this.status = WeatherStatus.initial,
    this.position,
    this.stations,
    this.dailyData,
    this.hourlyData,
    this.errorMessage,
    this.isLoading = false,
  });

  HomeState copyWith({
    WeatherStatus? status,
    Position? position,
    WeatherMeta? stations,
    WeatherDaily? dailyData,
    WeatherHourly? hourlyData,
    String? errorMessage,
    bool? isLoading,
  }) {
    return HomeState(
      status: status ?? this.status,
      position: position ?? this.position,
      stations: stations ?? this.stations,
      dailyData: dailyData ?? this.dailyData,
      hourlyData: hourlyData ?? this.hourlyData,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        status,
        position,
        stations,
        dailyData,
        hourlyData,
        errorMessage,
        isLoading,
      ];
}
