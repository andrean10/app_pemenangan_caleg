import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioInterceptor extends Interceptor {
  final _logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i('info: REQUEST[${options.method}] => PATH: ${options.path}');
    _logger.i(
        'info: REQUEST HEADERS [${options.headers}] => CONTENT TYPE: ${options.contentType}');
    _logger.i(
        'info: REQUEST QUERY PARAMS [${options.queryParameters}] => BODY: ${options.data}');
    inspect(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i(
        'info: RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    _logger.i(
        'info: RESPONSE MESSAGE[${response.statusMessage}] => DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    _logger.i(
        'info: ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    _logger.i(
        'info: ERROR MESSAGE[${err.response?.statusMessage}] => DATA ERROR: ${err.error}');
    super.onError(err, handler);
  }
}
