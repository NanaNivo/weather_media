import 'package:dio/dio.dart';
import 'package:weather/app+injection/di.dart';
import '../services/session_manager.dart';

class AuthInterceptor extends Interceptor {
  final SessionManager sessionManager;
  final Dio dio;
  RequestOptions? _previousRequest;

  AuthInterceptor(this.sessionManager, this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('add key to header for all request');
    _previousRequest = options;
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print("on Error${err.message}");
    if (err.type == DioErrorType.response) {
      // Handle specific API errors
      final response = err.response;
      if (response != null) {
        if (response.statusCode == 429) {
          // Rate limit exceeded
          handler.next(DioError(
            requestOptions: err.requestOptions,
            error: 'Rate limit exceeded. Please try again later.',
            type: err.type,
            response: err.response,
          ));
          return;
        }
      }
    }
    handler.next(err);
  }
}

mixin RefreshableRequest {
  final AuthInterceptor authInterceptor = locator<AuthInterceptor>();

  Dio getRefreshableDio() {
    final dio = Dio();

    dio.interceptors.add(authInterceptor);
    print("auth RefreshableRequest");
    return dio;
  }
}
