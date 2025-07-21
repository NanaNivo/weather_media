import 'package:dartz/dartz.dart';
import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/models/weather_meta_model.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/core/usecases/base_use_case.dart';
import 'package:weather/presentation/hom_flow/repository/repository_home.dart';

class NearbyStationsParams {
  final double latitude;
  final double longitude;
  final double? radius;
  final int? limit;

  NearbyStationsParams({
    required this.latitude,
    required this.longitude,
    this.radius,
    this.limit,
  });
}

class NearbyStationsUseCase
    implements
        UseCase<Future<Result<BaseError, WeatherMeta>>,
            NearbyStationsParams> {
  final RepositoryHome repository;

  NearbyStationsUseCase(this.repository);

  @override
  Future<Result<BaseError, WeatherMeta>> call(
      NearbyStationsParams params) async {
    return await repository.getNearbyStations(
      latitude: params.latitude,
      longitude: params.longitude,
      radius: params.radius,
      limit: params.limit,
    );
  }
}
