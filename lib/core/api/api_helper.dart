import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/error/http/forbidden_error.dart';

import '../enums/api/HttpMethod.dart';
import '../error/base_error.dart';
import '../error/connection/socket_error.dart';
import '../error/connection/unknown_error.dart';
import '../factories/ModelFactory.dart';
import 'handler.dart';
import 'auth_interceptor.dart';

class ApiHelper with ErrorHandler, RefreshableRequest {
  Future<Either<BaseError, T>> sendRequest<T>(
      {required HttpMethod method,
      required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      CancelToken? cancelToken,
      bool withRefreshToken = true}) async {
    Dio dio = Dio();
    // Dio dio = withRefreshToken ? getRefreshableDio() : c;
    try {
      Response? response;

      switch (method) {
        case HttpMethod.GET:
          print("GET [$url]");
          response = await dio.get(
            url,
            queryParameters: queryParameters ?? data,
            options: Options(
                headers: headers,
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500 && status != 401 && status != 403;
                }),
            cancelToken: cancelToken,
          );
          break;

        case HttpMethod.POST:
          print("POST [$url] data: [$data]");
          response = await dio.post(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(
                headers: headers,
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500 && status != 401 && status != 403;
                }),
            cancelToken: cancelToken,
          );

          break;
        case HttpMethod.PUT:
          response = await dio.put(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(
                headers: headers,
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500 && status != 401 && status != 403;
                }),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          print("DELETE [$url] data: [$data]");
          response = await dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(
                headers: headers,
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500 && status != 401 && status != 403;
                }),
            cancelToken: cancelToken,
          );
          break;
        default:
          break;
      }

      if (response?.data == null) {
        return Left(UnknownError());
      }

      var decoded = response?.data is String
          ? json.decode(response?.data)
          : response?.data;
      print('Response data: $decoded');

      return Right(ModelFactory.getInstance().createModel<T>(decoded));
    } on DioError catch (e) {
      BaseError error = _handleError(e);
      print('Error is ForbiddenError: ${error is ForbiddenError}');
      if (error is ForbiddenError) throw ForbiddenError();
      return Left(_handleError(e));
    } on SocketException {
      return Left(SocketError());
    } catch (e) {
      print('Error: $e');
      return Left(UnknownError());
    }
  }

  _handleError(error) => handleError(error);
}
