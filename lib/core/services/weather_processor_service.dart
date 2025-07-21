import 'dart:isolate';
import 'dart:math';
import 'package:weather/core/models/weather_hourly_daily_model.dart';
import 'package:weather/presentation/hom_flow/request/Weather_hourly_daily_request.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/presentation/hom_flow/usecase/usecase_weather_daily.dart';
import 'package:weather/presentation/hom_flow/usecase/usecase_weather_hourly.dart';
import 'package:intl/intl.dart';

class WeatherProcessorService {
  static Future<Map<String, dynamic>> fetchAndProcessWeatherData({
    required String station,
    required DateTime startDate,
    required DateTime endDate,
    required WeatherDailyUseCase dailyUseCase,
    required WeatherHourlyUseCase hourlyUseCase,
  }) async {
    final receivePort = ReceivePort();

    await Isolate.spawn(
      _fetchAndProcessInIsolate,
      {
        'sendPort': receivePort.sendPort,
        'station': station,
        'startDate': startDate,
        'endDate': endDate,
        'dailyUseCase': dailyUseCase,
        'hourlyUseCase': hourlyUseCase,
      },
    );

    final processed = await receivePort.first;
    receivePort.close();
    return processed as Map<String, dynamic>;
  }

  static Future<void> _fetchAndProcessInIsolate(
      Map<String, dynamic> message) async {
    final SendPort sendPort = message['sendPort'];
    final String station = message['station'];
    final DateTime startDate = message['startDate'];
    final DateTime endDate = message['endDate'];
    final WeatherDailyUseCase dailyUseCase = message['dailyUseCase'];
    final WeatherHourlyUseCase hourlyUseCase = message['hourlyUseCase'];

    try {
      // Create request
      final request = WeatherHourlyDailyRequest(
        station: station,
        start: DateFormat('yyyy-MM-dd').format(startDate),
        end: DateFormat('yyyy-MM-dd').format(endDate),
      );

      // Fetch data in parallel
      final results = await Future.wait([
        dailyUseCase(WeatherDailyParams(request: request)),
        hourlyUseCase(WeatherHourlyParams(request: request)),
      ]);

      final dailyResult = results[0] ;
      final hourlyResult = results[1] ;

      if (!dailyResult.hasDataOnly || !hourlyResult.hasDataOnly) {
        sendPort.send({
          'error': 'Failed to fetch weather data',
          'hasError': true,
        });
        return;
      }

      // Process data
      final processedHourly = _processHourlyData(hourlyResult.data as WeatherHourly);
      final processedDaily = _processDailyData(dailyResult.data as WeatherDaily);

      sendPort.send({
        'hourly': processedHourly,
        'daily': processedDaily,
        'hasError': false,
      });
    } catch (e) {
      sendPort.send({
        'error': 'Error processing weather data: $e',
        'hasError': true,
      });
    }
  }

  static Map<String, dynamic>? _processHourlyData(WeatherHourly? hourlyData) {
    if (hourlyData?.data == null) return null;

    final processedData = hourlyData!.data!.map((hour) {
      // Calculate feels like temperature
      final feelsLike = _calculateFeelsLike(
        hour.temp ?? 0,
        hour.rhum ?? 0,
        hour.wspd ?? 0,
      );

      // Process precipitation probability
      final precipProb = _calculatePrecipitationProbability(
        hour.rhum ?? 0,
        hour.pres ?? 0,
      );

      return {
        ...hour.toJson(),
        'feels_like': feelsLike,
        'precip_prob': precipProb,
      };
    }).toList();

    return {
      'data': processedData,
      'processed_at': DateTime.now().toIso8601String(),
    };
  }

  static Map<String, dynamic>? _processDailyData(WeatherDaily? dailyData) {
    if (dailyData?.data == null) return null;

    final processedData = dailyData!.data!.map((day) {
      // Calculate average temperature
      final avgTemp = ((day.tmax ?? 0) + (day.tmin ?? 0)) / 2;

      // Calculate temperature range
      final tempRange = (day.tmax ?? 0) - (day.tmin ?? 0);

      return {
        ...day.toJson(),
        'avg_temp': avgTemp,
        'temp_range': tempRange,
      };
    }).toList();

    return {
      'data': processedData,
      'processed_at': DateTime.now().toIso8601String(),
    };
  }

  static double _calculateFeelsLike(
      double temp, double humidity, double windSpeed) {
    if (temp > 20) {
      return 0.5 * (temp + 61.0 + ((temp - 68.0) * 1.2) + (humidity * 0.094));
    } else if (temp < 10 && windSpeed > 4.8) {
      return 13.12 +
          0.6215 * temp -
          11.37 * pow(windSpeed, 0.16) +
          0.3965 * temp * pow(windSpeed, 0.16);
    }
    return temp;
  }

  static double _calculatePrecipitationProbability(
      double humidity, double pressure) {
    double probability = (humidity - 50) * 2;
    if (pressure < 1000) probability += 20;
    if (pressure > 1020) probability -= 20;

    return probability.clamp(0, 100);
  }
}
