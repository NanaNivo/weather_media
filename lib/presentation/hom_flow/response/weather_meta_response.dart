


import 'package:weather/core/models/weather_meta_model.dart';
import 'package:weather/core/response/api_response.dart';

class WeatherMetaResponse extends ApiResponse<WeatherMeta?>
{
  WeatherMetaResponse(String msg, bool hasError, result) : super(msg, hasError, result) ;

  factory WeatherMetaResponse.fromJson(json) {
    print('hi there');
    final error = json['error'];
    bool isError = error != null;
    if(isError) {
      int status = error["status"];
    }

    String message ='';


    WeatherMeta? model;
    if (!isError) {
      isError = false;
      print('response in Pokemonresponse');
      model = WeatherMeta.fromJson(json);

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

    return WeatherMetaResponse(message, isError, model);
  }
}