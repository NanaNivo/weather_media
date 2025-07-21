import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class GetWeatherDataEvent extends HomeEvent {
  final String location;

  const GetWeatherDataEvent({required this.location});

  @override
  List<Object?> get props => [location];
}

class GetMyLocationEvent extends HomeEvent {
  const GetMyLocationEvent();
}

class GetNearbyStationsEvent extends HomeEvent {
  final double latitude;
  final double longitude;

  const GetNearbyStationsEvent({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

class GetStationWeatherEvent extends HomeEvent {
  final String station;
  final DateTime startDate;
  final DateTime endDate;

  const GetStationWeatherEvent({
    required this.station,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [station, startDate, endDate];
}
