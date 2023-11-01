import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/korlap/header/response/header_pendukung_model.dart';
import '../../../../services/pendukung/pendukung_services.dart';

class SuaraTpsKlpController extends GetxController {
  late PendukungServices _pendukungS;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    _pendukungS = PendukungServices();
  }

  Future<HeaderPendukungModel?> fetchHeaderPendukung() async {
    try {
      final response = await _pendukungS.fetchHeaderPendukung(2);
      if (response.statusCode == HttpStatus.ok) {
        return HeaderPendukungModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      logger.e('Error: $e');
      return null;
    }
  }
}
