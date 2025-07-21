


import 'package:weather/core/response/api_response.dart';
import 'package:weather/core/models/weather_hourly_daily_model.dart';

class WeatherHourlyResponse extends ApiResponse<WeatherHourly?>
{
  WeatherHourlyResponse(String msg, bool hasError, result) : super(msg, hasError, result) ;

  factory WeatherHourlyResponse.fromJson(json) {
    print('hi there');
    final error = json['error'];
    bool isError = error != null;
    if(isError) {
      int status = error["status"];
    }

    String message ='';


    WeatherHourly? model;
    if (!isError) {
      isError = false;
      print('response in Pokemonresponse');
      model = WeatherHourly.fromJson(json);

    } else if (isError) {
      print('response in Pokemonresponse error');

      message = error['message'];
      if(error['details']!=null)
      {
        message = '';
        error['details']['errors'].forEach((v) {
          message += ' ${v['message']}\n';
        });
      }
    }

    return WeatherHourlyResponse(message, isError, model);
  }
}