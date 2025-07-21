


import 'package:weather/core/response/api_response.dart';
import 'package:weather/core/models/weather_hourly_daily_model.dart';

class WeatherDailyResponse extends ApiResponse<WeatherDaily?>
{
  WeatherDailyResponse(String msg, bool hasError, result) : super(msg, hasError, result) ;

  factory WeatherDailyResponse.fromJson(json) {
    print('hi there');
    final error = json['error'];
    bool isError = error != null;
    if(isError) {
      int status = error["status"];
    }

    String message ='';


    WeatherDaily? model;
    if (!isError) {
      isError = false;
      print('response in Pokemonresponse');
      model = WeatherDaily.fromJson(json);

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

    return WeatherDailyResponse(message, isError, model);
  }
}