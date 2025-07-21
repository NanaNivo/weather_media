import 'package:dartz/dartz.dart';
import 'package:weather/core/datasources/remote_data_source.dart';
import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/models/weather_meta_model.dart';
import 'package:weather/presentation/hom_flow/request/weather_meta_request.dart';
import 'package:weather/core/models/weather_hourly_daily_model.dart';
import 'package:weather/presentation/hom_flow/request/Weather_hourly_daily_request.dart';
import 'package:weather/presentation/hom_flow/request/nearby_stations_request.dart';

abstract class DataSourceHome extends RemoteDataSource {
  Future<Either<BaseError, WeatherMeta>> getWeatherMeta(
      {required WeatherMetaRequest data});
  Future<Either<BaseError, WeatherHourly>> getWeatherHourly(
      {required WeatherHourlyDailyRequest data});
  Future<Either<BaseError, WeatherDaily>> getWeatherDaily(
      {required WeatherHourlyDailyRequest data});
  Future<Either<BaseError, WeatherMeta>> getNearbyStations(
      {required NearbyStationsRequest request});
  //Future<Either<BaseError,Object>> getMyLocation({GetLocationRequest data});
}
