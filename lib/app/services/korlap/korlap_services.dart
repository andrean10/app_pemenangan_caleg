import 'package:app_pemenangan_caleg/app/modules/init/controller/init_controller.dart';
import 'package:app_pemenangan_caleg/app/services/main_services.dart';
import 'package:dio/dio.dart' as dio_r;
import 'package:get/get.dart';

class KorlapServices extends MainServices {
  String? token;
  late final InitController _initC;

  KorlapServices() {
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    token = _initC.getToken();
  }

  Future<dio_r.Response> fetchKorlap({required int page}) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'users',
      queryParameters: {
        'page': page,
        'roles': 'koordinator',
      },
    );
  }

  Future<dio_r.Response> fetchTPSKorlap({
    required int page,
    required int tpsId,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'koordinator',
      queryParameters: {
        'page': page,
        'tps_id': tpsId,
      },
    );
  }

  Future<dio_r.Response> fetchListTPSKorlap({required int page}) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'koordinator/usersKoordinator',
      queryParameters: {
        'page': page,
      },
    );
  }

  Future<dio_r.Response> addDataKorlap(dio_r.FormData model) async {
    if (token != null) {
      dio.options
        ..headers['Authorization'] = 'Bearer $token'
        ..contentType = dio_r.Headers.multipartFormDataContentType;
    }

    return await dio.post(
      'users/store',
      data: model,
    );
  }

  Future<dio_r.Response> updateDataKorlap({
    required int id,
    required dio_r.FormData model,
  }) async {
    if (token != null) {
      dio.options
        ..headers['Authorization'] = 'Bearer $token'
        ..contentType = dio_r.Headers.multipartFormDataContentType;
    }

    return await dio.post(
      'users/$id/update?_method=put',
      data: model,
    );
  }

  Future<dio_r.Response> deleteDataKorlap(
    int id,
  ) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.delete('users/$id/destroy');
  }

  Future<dio_r.Response> addTPSKorlap(Map<String, dynamic> model) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.post(
      'koordinator/store',
      data: model,
    );
  }

  Future<dio_r.Response> updateTPSKorlap({
    required int id,
    required Map<String, dynamic> model,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.post(
      'koordinator/$id/update?_method=put',
      data: model,
    );
  }

  Future<dio_r.Response> deleteTPSKorlap(int id) {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return dio.delete('koordinator/$id/destroy?_method=delete');
  }

  Future<dio_r.Response> fetchJabatan() async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get('jabatan');
  }
}
