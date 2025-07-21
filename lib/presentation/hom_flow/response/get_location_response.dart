


import 'package:weather/core/response/api_response.dart';

class GetLocationResponse extends ApiResponse<Object?>
{
  GetLocationResponse(String msg, bool hasError, result) : super(msg, hasError, result) ;

  factory GetLocationResponse.fromJson(json) {
    print('hi there');
    final error = json['error'];
    bool isError = error != null;
    if(isError) {
      int status = error["status"];
    }

    String message ='';


    Object? model;
    if (!isError) {
      isError = false;
      print('response in Pokemonresponse');
    //  model = WeatherDaily.fromJson(json);

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

    return GetLocationResponse(message, isError, model);
  }
}