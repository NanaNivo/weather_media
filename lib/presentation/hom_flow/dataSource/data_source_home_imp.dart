import 'package:dartz/dartz.dart';
import 'package:weather/core/enums/api/HttpMethod.dart';
import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/models/weather_meta_model.dart';
import 'package:weather/core/resources/strings.dart';
import 'package:weather/presentation/hom_flow/dataSource/data_source_home.dart';
import 'package:weather/presentation/hom_flow/request/get_location_request.dart';
import 'package:weather/presentation/hom_flow/request/weather_meta_request.dart';
import 'package:weather/presentation/hom_flow/response/weather_meta_response.dart';
import 'package:weather/presentation/hom_flow/request/Weather_hourly_daily_request.dart';
import 'package:weather/core/models/weather_hourly_daily_model.dart';
import 'package:weather/presentation/hom_flow/response/Weather_hourly.dart';
import 'package:weather/presentation/hom_flow/response/Weather_daily_response.dart';
import 'package:weather/presentation/hom_flow/request/nearby_stations_request.dart';

class DataSourceHomeImp extends DataSourceHome {
  @override
  Future<Either<BaseError, WeatherMeta>> getWeatherMeta(
      {required WeatherMetaRequest data}) {
    return request<WeatherMeta, WeatherMetaResponse>(
      responseStr: 'WeatherMetaResponse',
      mapper: (json) => WeatherMetaResponse.fromJson(json),
      method: HttpMethod.GET,
      data: data.toJson(),
      acceptLang: data.language ?? 'en',
      url: stationsMeta,
    );
  }

  @override
  Future<Either<BaseError, WeatherHourly>> getWeatherHourly(
      {required WeatherHourlyDailyRequest data}) {
    return request<WeatherHourly, WeatherHourlyResponse>(
      responseStr: 'WeatherHourlyResponse',
      mapper: (json) => WeatherHourlyResponse.fromJson(json),
      method: HttpMethod.GET,
      data: data.toJson(),
      acceptLang: data.language ?? 'en',
      url: stationsHourly,
    );
  }

  @override
  Future<Either<BaseError, WeatherDaily>> getWeatherDaily(
      {required WeatherHourlyDailyRequest data}) {
    return request<WeatherDaily, WeatherDailyResponse>(
      responseStr: 'WeatherDailyResponse',
      mapper: (json) => WeatherDailyResponse.fromJson(json),
      method: HttpMethod.GET,
      data: data.toJson(),
      acceptLang: data.language ?? 'en',
      url: stationsDaily,
    );
  }

  Future<Either<BaseError, WeatherMeta>> getNearbyStations({
    required NearbyStationsRequest request,
  }) async {
    return this.request<WeatherMeta, WeatherMetaResponse>(
      responseStr: 'WeatherMetaResponse',
      mapper: (json) => WeatherMetaResponse.fromJson(json),
      method: HttpMethod.GET,
      data: request.toJson(),
      url: stationsNearby,
    );
  }
}
