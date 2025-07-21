import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/config/api_config.dart';

import '../api/api_helper.dart';
import '../enums/api/HttpMethod.dart';
import '../error/base_error.dart';
import '../error/custom_error.dart';
import '../factories/ModelFactory.dart';
import '../response/api_response.dart';

abstract class RemoteDataSource {
  Future<Either<BaseError, Data>> request<Data, Response extends ApiResponse>({
    required String responseStr,
    required Response Function(dynamic) mapper,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
     Map<String, dynamic>? data,
    String? token,
    CancelToken? cancelToken,
    String? acceptLang,
  }) async {
    try {
      ModelFactory.getInstance().registerModel(responseStr, mapper);

      // Set up headers
      final Map<String, String> headers = {
        'x-rapidapi-host': ApiConfig.rapidApiHost,
        'x-rapidapi-key': ApiConfig.rapidApiKey,
        'Content-Type': 'application/json',
      };

      if (acceptLang != null) {
        headers['Accept-Language'] = acceptLang;
      }

      print('Request headers: $headers');
      print('Request data: $data');

      final response = await ApiHelper().sendRequest<Response>(
        method: method,
        url: url,
        data: data,
        headers: headers,
        queryParameters: queryParameters,
        cancelToken: cancelToken ?? CancelToken(),
      );

      print('API Response: $response');

      if (response.isLeft()) {
        return Left((response as Left<BaseError, Response>).value);
      } else if (response.isRight()) {
        final resValue = (response as Right<BaseError, Response>).value;
        print('has error : ${resValue.hasError}');
        if (resValue.hasError) return Left(CustomError(message: resValue.msg));
        return Right(resValue.result);
      }
      return Left(CustomError(message: 'Unknown error'));
    } catch (e) {
      print('Error in request: $e');
      return Left(CustomError(message: 'Request failed: ${e.toString()}'));
    }
  }
}
