import 'package:dartz/dartz.dart';
import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/models/weather_meta_model.dart';
import 'package:weather/core/models/weather_hourly_daily_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/repositories/repository.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/presentation/hom_flow/request/Weather_hourly_daily_request.dart';

abstract class RepositoryHome extends Repository {
  Future<Result<BaseError, Position>> getMyLocation();
  Future<Result<BaseError, WeatherDaily>> weatherDailyRepo(
      WeatherHourlyDailyRequest weatherHourlyDailyRequest);
  Future<Result<BaseError, WeatherHourly>> weatherHourlyRepo(
      WeatherHourlyDailyRequest weatherHourlyDailyRequest);
  Future<Result<BaseError, WeatherMeta>> getNearbyStations({
    required double latitude,
    required double longitude,
    double? radius,
    int? limit,
  });
}
