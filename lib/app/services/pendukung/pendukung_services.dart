import 'package:app_pemenangan_caleg/app/services/main_services.dart';
import 'package:dio/dio.dart' as dio_r;
import 'package:get/get.dart';

import '../../modules/init/controller/init_controller.dart';

class PendukungServices extends MainServices {
  String? token;
  late final InitController _initC;

  PendukungServices() {
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    token = _initC.getToken();
  }

  Future<dio_r.Response> fetchPendukung({required int page}) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'users',
      queryParameters: {
        'page': page,
        'roles': 'pendukung',
      },
    );
  }

  Future<dio_r.Response> fetchPendukungByKorlap({required int page}) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'dataPendukung',
      queryParameters: {'page': page},
    );
  }

  Future<dio_r.Response> fetchPendukungByTPS({
    required int page,
    required int tpsId,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'pendukung',
      queryParameters: {
        'page': page,
        'tps_id': tpsId,
      },
    );
  }

  Future<dio_r.Response> fetchListPendukung(int page) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'pendukung/usersPendukung',
      queryParameters: {
        'page': page,
      },
    );
  }

  Future<dio_r.Response> fetchHeaderPendukung(int tpsId) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'dataPendukung/getHeaderTps',
      queryParameters: {
        'tps_id': tpsId,
      },
    );
  }

  Future<dio_r.Response> addPendukung(Map<String, dynamic> model) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.post(
      'pendukung/store',
      data: model,
    );
  }

  Future<dio_r.Response> updatePendukung({
    required int id,
    required Map<String, dynamic> model,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.post(
      'pendukung/$id/update?_method=put',
      data: model,
    );
  }

  Future<dio_r.Response> deletePendukung(int tpsId) {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return dio.delete('pendukung/$tpsId/destroy?_method=delete');
  }

  Future<dio_r.Response> uploadBuktiLapangan({
    required int id,
    required dio_r.FormData model,
  }) async {
    if (token != null) {
      dio.options
        ..headers['Authorization'] = 'Bearer $token'
        ..contentType = dio_r.Headers.multipartFormDataContentType;
    }

    return await dio.post(
      'dataPendukung/$id/store',
      data: model,
    );
  }

  Future<dio_r.Response> uploadBuktiCoblos({
    required int id,
    required dio_r.FormData model,
  }) async {
    if (token != null) {
      dio.options
        ..headers['Authorization'] = 'Bearer $token'
        ..contentType = dio_r.Headers.multipartFormDataContentType;
    }

    return await dio.post(
      'dataPendukung/$id/uploadCoblos',
      data: model,
    );
  }
}
