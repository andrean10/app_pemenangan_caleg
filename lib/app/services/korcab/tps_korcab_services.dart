import 'package:app_pemenangan_caleg/app/data/models/korcab/tps/response/data_tps_korcab.dart';
import 'package:app_pemenangan_caleg/app/modules/init/controller/init_controller.dart';
import 'package:app_pemenangan_caleg/app/services/main_services.dart';
import 'package:dio/dio.dart' as dio_r;
import 'package:get/get.dart';

class TpsKorcabServices extends MainServices {
  String? token;
  late final InitController _initC;

  TpsKorcabServices() {
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    token = _initC.getToken();
  }

  Future<dio_r.Response> fetchTPS({required int page}) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'tps',
      queryParameters: {'page': page},
    );
  }

  Future<dio_r.Response> fetchPendukung(int tpsId) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'pendukung',
      queryParameters: {
        'page': 1,
        'tps_id': tpsId,
      },
    );
  }

  Future<dio_r.Response> fetchProvince({required int page}) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'provinsi',
      queryParameters: {'page': page},
    );
  }

  Future<dio_r.Response> fetchRegencies({
    required int page,
    required int provinceId,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'kabupaten',
      queryParameters: {
        'page': page,
        'provinces_id': provinceId,
      },
    );
  }

  Future<dio_r.Response> fetchDistrict({
    required int page,
    required int regenciesId,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    return await dio.get(
      'kecamatan',
      queryParameters: {'page': page, 'regency_id': regenciesId},
    );
  }

  Future<dio_r.Response> fetchVillages({
    required int page,
    required int distrcitId,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get(
      'kelurahan',
      queryParameters: {'page': page, 'district_id': distrcitId},
    );
  }

  Future<dio_r.Response> addTPS(DataTpsKorcab model) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.post(
      'tps/store',
      data: model.toJson(),
    );
  }

  Future<dio_r.Response> updateTPS({
    required int id,
    required DataTpsKorcab model,
  }) async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.post(
      'tps/$id/update?_method=put',
      data: model.toJson(),
    );
  }

  Future<dio_r.Response> deleteTPS(int id) {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return dio.post('tps/$id/destroy?_method=delete');
  }
}
