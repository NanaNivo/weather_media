import 'package:weather/core/error/base_error.dart';
import 'package:weather/core/models/weather_hourly_daily_model.dart';
import 'package:weather/core/param/base_param.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/core/usecases/base_use_case.dart';
import 'package:weather/presentation/hom_flow/repository/repository_home.dart';
import 'package:weather/presentation/hom_flow/request/Weather_hourly_daily_request.dart';

class WeatherDailyUseCase extends UseCase<
    Future<Result<BaseError, WeatherDaily>>, WeatherDailyParams> {
  final RepositoryHome homeRepository;

  WeatherDailyUseCase({required this.homeRepository});

  @override
  Future<Result<BaseError, WeatherDaily>> call(
      WeatherDailyParams params) async {
    final result = await homeRepository.weatherDailyRepo(
       params.request,
    );
    return result;
  }
}

class WeatherDailyParams extends BaseParams {
  final WeatherHourlyDailyRequest request;

  WeatherDailyParams({required this.request});
}
