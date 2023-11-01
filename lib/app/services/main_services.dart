import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/constants_endpoint.dart';

class MainServices {
  final dio = Dio();

  MainServices() {
    _configureDio();
  }

  void _configureDio() {
    dio.options
      ..baseUrl = ConstantsEndpoint.main
      ..connectTimeout = 15.seconds
      ..receiveTimeout = 30.seconds
      ..contentType = Headers.formUrlEncodedContentType;
    dio.interceptors.add(PrettyDioLogger());
  }

  void setAuthorization() {}

  String infoDio() {
    return dio.options.toString();
  }
}
