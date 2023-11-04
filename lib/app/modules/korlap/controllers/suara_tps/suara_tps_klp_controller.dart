import 'dart:io';

import 'package:app_pemenangan_caleg/app/data/models/korlap/dashboard/response/dashboard_suara_tps_korlap_model.dart';
import 'package:app_pemenangan_caleg/app/services/dashboard/dashboard_services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SuaraTpsKlpController extends GetxController {
  late DashboardServices _dashboardS;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    _dashboardS = DashboardServices();
  }

  Future<DashboardSuaraTpsKorlapModel?> fetchKorlapSuaraTps() async {
    try {
      final response = await _dashboardS.fetchKorlapSuaraTps();
      if (response.statusCode == HttpStatus.ok) {
        return DashboardSuaraTpsKorlapModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      logger.e('Error: $e');
      return null;
    }
  }
}
