import 'package:dartz/dartz.dart';
import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/models/weather_meta_model.dart';
import 'package:weather/core/models/weather_hourly_daily_model.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/core/services/location_service.dart';
import 'package:weather/presentation/hom_flow/dataSource/data_source_home.dart';
import 'package:weather/presentation/hom_flow/repository/repository_home.dart';
import 'package:weather/presentation/hom_flow/request/Weather_hourly_daily_request.dart';
import 'package:weather/presentation/hom_flow/request/nearby_stations_request.dart';
import 'package:geolocator/geolocator.dart';

class HomeRepositoryImp extends RepositoryHome {
  final DataSourceHome dataSource;
  final LocationService _locationService;

  HomeRepositoryImp(this.dataSource, this._locationService);

  @override
  Future<Result<BaseError, WeatherDaily>> weatherDailyRepo(
      WeatherHourlyDailyRequest weatherHourlyDailyRequest) async {
   // final request = WeatherHourlyDailyRequest.fromJson(data);
    final res=await dataSource.getWeatherDaily(data: weatherHourlyDailyRequest);
    return executeWithoutConvert(remoteResult: res);
  }

  @override
  Future<Result<BaseError, WeatherHourly>> weatherHourlyRepo(
      WeatherHourlyDailyRequest weatherHourlyDailyRequest) async {

    final res= await dataSource.getWeatherHourly(data: weatherHourlyDailyRequest);
    return executeWithoutConvert(remoteResult: res);
  }

  @override
  Future<Result<BaseError, Position>> getMyLocation() async {
    return await _locationService.getCurrentLocation();
  }

  @override
  Future<Result<BaseError, WeatherMeta>> getNearbyStations({
    required double latitude,
    required double longitude,
    double? radius,
    int? limit,
  }) async {
    final request = NearbyStationsRequest(
      latitude: latitude,
      longitude: longitude,
      radius: radius,
      limit: limit,
    );
    final res= await dataSource.getNearbyStations(request: request);
    return executeWithoutConvert(remoteResult: res);
  }
}
