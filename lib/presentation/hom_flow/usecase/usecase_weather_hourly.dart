import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/models/weather_hourly_daily_model.dart';
import 'package:weather/core/param/base_param.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/core/usecases/base_use_case.dart';
import 'package:weather/presentation/hom_flow/repository/repository_home.dart';
import 'package:weather/presentation/hom_flow/request/Weather_hourly_daily_request.dart';

class WeatherHourlyUseCase extends UseCase<
    Future<Result<BaseError, WeatherHourly>>, WeatherHourlyParams> {
  final RepositoryHome homeRepository;

  WeatherHourlyUseCase({required this.homeRepository});

  @override
  Future<Result<BaseError, WeatherHourly>> call(
      WeatherHourlyParams params) async {
    final result = await homeRepository.weatherHourlyRepo(
   params.request,
    );
    return result;
  }
}

class WeatherHourlyParams extends BaseParams {
  final WeatherHourlyDailyRequest request;

  WeatherHourlyParams({required this.request});
}
