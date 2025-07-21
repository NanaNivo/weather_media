import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/hom_flow/bloc/event_home.dart';
import 'package:weather/presentation/hom_flow/bloc/state_home.dart';
import 'package:weather/presentation/hom_flow/usecase/usecase_get_location.dart';
import 'package:weather/presentation/hom_flow/usecase/usecase_weather_daily.dart';
import 'package:weather/presentation/hom_flow/usecase/usecase_weather_hourly.dart';
import 'package:weather/presentation/hom_flow/usecase/usecase_nearby_stations.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/presentation/hom_flow/request/Weather_hourly_daily_request.dart';
import 'package:weather/core/param/no_param.dart';
import 'package:intl/intl.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocationUseCase locationUseCase;
  final WeatherDailyUseCase weatherDailyUseCase;
  final WeatherHourlyUseCase weatherHourlyUseCase;
  final NearbyStationsUseCase nearbyStationsUseCase;

  HomeBloc({
    required this.locationUseCase,
    required this.weatherDailyUseCase,
    required this.weatherHourlyUseCase,
    required this.nearbyStationsUseCase,
  }) : super(const HomeState()) {
    on<GetMyLocationEvent>(_onGetMyLocation);
    on<GetNearbyStationsEvent>(_onGetNearbyStations);
    on<GetStationWeatherEvent>(_onGetStationWeather);
  }

  Future<void> _onGetMyLocation(
    GetMyLocationEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: WeatherStatus.loading,
      isLoading: true,
    ));


      final result = await locationUseCase(NoParams());
      if (result.hasDataOnly) {
        final position = result.data!;
        emit(state.copyWith(
          status: WeatherStatus.locationLoaded,
          position: position,
          isLoading: false,
        ));

        // Get nearby stations
        add(GetNearbyStationsEvent(
          latitude: position.latitude,
          longitude: position.longitude,
        ));
      } else if (result.error != null) {
        emit(state.copyWith(
          status: WeatherStatus.error,
          errorMessage: result.error!.toString(),
          isLoading: false,
        ));
      }

  }

  Future<void> _onGetNearbyStations(
    GetNearbyStationsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: WeatherStatus.loading,
      isLoading: true,
    ));


    final params = NearbyStationsParams(
      latitude: event.latitude,
      longitude: event.longitude,
      limit: 5, // Get 5 nearest stations
      radius: 50000, // Within 50km (50,000 meters)
    );

    final stationsResult = await nearbyStationsUseCase(params);

    if (stationsResult.hasDataOnly) {
      final stations = stationsResult.data;
      if (stations != null ) {
        emit(state.copyWith(
          status: WeatherStatus.stationsLoaded,
          stations: stations,
          isLoading: false,
        ));

        // Get weather data for the nearest station
        final nearestStation = stationsResult.data!.data!.first;
        final now = DateTime.now();
        final startDate = DateTime(now.year, now.month, 1);
        final endDate = DateTime(now.year, now.month + 1, 0);

        add(GetStationWeatherEvent(
          station: nearestStation.id!,
          startDate: startDate,
          endDate: endDate,
        ));
      } else {
        emit(state.copyWith(
          status: WeatherStatus.error,
          errorMessage: 'No weather stations found nearby',
          isLoading: false,
        ));
      }
    }
  }






  Future<void> _onGetStationWeather(
    GetStationWeatherEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: WeatherStatus.loading,
      isLoading: true,
    ));


      final request = WeatherHourlyDailyRequest(
        station: event.station,
        start: DateFormat('yyyy-MM-dd').format(event.startDate),
        end: DateFormat('yyyy-MM-dd').format(event.endDate),
      );

      // Get daily weather data
      final dailyResult = await weatherDailyUseCase(WeatherDailyParams(
        request: request,
      ));

      // Get hourly weather data
      final hourlyResult = await weatherHourlyUseCase(WeatherHourlyParams(
        request: request,
      ));

      if (dailyResult.hasDataOnly || hourlyResult.hasDataOnly) {
        emit(state.copyWith(
          status: WeatherStatus.weatherLoaded,
          dailyData: dailyResult.data,
          hourlyData: hourlyResult.data,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          status: WeatherStatus.error,
          errorMessage: 'Failed to get weather data',
          isLoading: false,
        ));
      }

  }
}
