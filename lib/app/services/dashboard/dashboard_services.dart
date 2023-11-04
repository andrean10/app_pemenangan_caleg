import 'package:app_pemenangan_caleg/app/services/main_services.dart';
import 'package:dio/dio.dart' as dio_r;
import 'package:get/get.dart';

import '../../modules/init/controller/init_controller.dart';

class DashboardServices extends MainServices {
  String? token;
  late final InitController _initC;

  DashboardServices() {
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    token = _initC.getToken();
  }

  Future<dio_r.Response> fetchKorcabSuaraTps() async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get('home/semuaSuara');
  }

  Future<dio_r.Response> fetchKorlapSuaraTps() async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get('home/suaraKoordinator');
  }

  Future<dio_r.Response> fetchKorlapDataPendukung() async {
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio.get('home/pendukungKoordinator');
  }
}
