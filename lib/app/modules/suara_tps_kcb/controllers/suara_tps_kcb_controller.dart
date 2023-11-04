import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/models/korcab/dashboard/response/dashboard_suara_tps_korcab_model.dart';
import '../../../services/dashboard/dashboard_services.dart';

class SuaraTpsKcbController extends GetxController {
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

  Future<DashboardSuaraTpsKorcabModel?> fetchKorcabSuaraTps() async {
    try {
      final response = await _dashboardS.fetchKorcabSuaraTps();
      if (response.statusCode == HttpStatus.ok) {
        return DashboardSuaraTpsKorcabModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      logger.e('Error: $e');
    }

    return null;
  }
}
