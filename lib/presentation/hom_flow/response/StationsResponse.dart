import 'package:weather/core/models/weather_meta_model.dart';
import 'package:weather/core/response/api_response.dart';

class StationsResponse extends ApiResponse<List<WeatherStation>?> {
  StationsResponse(String msg, bool hasError, List<WeatherStation>? result)
      : super(msg, hasError, result);

  factory StationsResponse.fromJson(dynamic json) {
    print('Parsing stations response');
    final error = json['error'];
    bool isError = error != null;
    String message = '';

    List<WeatherStation>? stations;
    if (!isError) {
      isError = false;
      if (json['data'] != null) {
        stations = [];
        json['data'].forEach((v) {
          stations!.add(WeatherStation.fromJson(v));
        });
      }
    } else {
      message = error['message'];
      if (error['details'] != null) {
        message = '';
        error['details']['errors'].forEach((v) {
          message += ' ${v['message']}\n';
        });
      }
    }

    return StationsResponse(message, isError, stations);
  }
}
