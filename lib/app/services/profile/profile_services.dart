import 'package:app_pemenangan_caleg/app/services/main_services.dart';
import 'package:dio/dio.dart' as dio_r;
import 'package:get/get.dart';

import '../../modules/init/controller/init_controller.dart';

class ProfileServices extends MainServices {
  String? token;
  late final InitController _initC;

  ProfileServices() {
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    token = _initC.getToken();
  }

  Future<dio_r.Response> fetchProfile() async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get('profile');
  }

  Future<dio_r.Response> updateProfile({
    required int id,
    required dio_r.FormData model,
  }) async {
    if (token != null) {
      dio.options
        ..headers['Authorization'] = 'Bearer $token'
        ..contentType = dio_r.Headers.multipartFormDataContentType;
    }

    return await dio.post(
      'profile/$id',
      data: model,
    );
  }

  Future<dio_r.Response> fetchJabatan() async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get('jabatan');
  }
}
