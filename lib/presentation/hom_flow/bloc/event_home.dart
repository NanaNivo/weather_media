import 'package:weather/presentation/hom_flow/bloc/state_home.dart';

abstract class HomeEvent {}

class GetMyLocationEvent extends HomeEvent {}

class GetNearbyStationsEvent extends HomeEvent {
  final double latitude;
  final double longitude;

  GetNearbyStationsEvent({
    required this.latitude,
    required this.longitude,
  });
}

class GetStationWeatherEvent extends HomeEvent {
  final String station; // Station ID
  final DateTime startDate;
  final DateTime endDate;
  final String? language;

  GetStationWeatherEvent({
    required this.station,
    required this.startDate,
    required this.endDate,
    this.language,
  });
}
