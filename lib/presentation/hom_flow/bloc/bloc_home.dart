import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/services/weather_processor_service.dart';
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
      if (stations != null) {
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

    try {
      // Use isolate for both fetching and processing
      final result = await WeatherProcessorService.fetchAndProcessWeatherData(
        station: event.station,
        startDate: event.startDate,
        endDate: event.endDate,
        dailyUseCase: weatherDailyUseCase,
        hourlyUseCase: weatherHourlyUseCase,
      );

      if (result['hasError'] == true) {
        emit(state.copyWith(
          status: WeatherStatus.error,
          errorMessage: result['error'] as String,
          isLoading: false,
        ));
        return;
      }

      emit(state.copyWith(
        status: WeatherStatus.weatherLoaded,
        dailyData: result['daily']?['data'],
        hourlyData: result['hourly']?['data'],
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        errorMessage: 'Error: ${e.toString()}',
        isLoading: false,
      ));
    }
  }
}
