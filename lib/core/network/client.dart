import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

extension DioExtension on Dio {
  Dio initClient(String baseUrl) {
    options.baseUrl = baseUrl;
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);
    options.sendTimeout = const Duration(seconds: 180);

    if (kDebugMode) interceptors.add(LogInterceptor(responseBody: true));
    return this;
  }
}
