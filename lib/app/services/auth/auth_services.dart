import 'package:app_pemenangan_caleg/app/data/models/auth/login/request/request_login_model.dart';
import 'package:app_pemenangan_caleg/app/services/main_services.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AuthServices extends MainServices {
  final logger = Logger();

  Future<Response> login(RequestLoginModel model) {
    return dio.post(
      'login',
      data: model.toJson(),
    );
  }
}
