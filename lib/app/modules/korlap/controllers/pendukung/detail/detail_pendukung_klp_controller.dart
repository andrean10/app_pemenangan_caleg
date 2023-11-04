import 'dart:io';

import 'package:app_pemenangan_caleg/app/data/models/korlap/pendukung/response/data_pendukung_korlap.dart';
import 'package:app_pemenangan_caleg/app/services/pendukung/pendukung_services.dart';
import 'package:app_pemenangan_caleg/app/shared/shared_method.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/constants_lottie.dart';
import '../pendukung_klp_controller.dart';

class DetailPendukungKlpController extends GetxController {
  late DataPendukungKorlap args;
  late PendukungServices _pendukungS;
  late PendukungKlpController _pendukungKlpC;
  late ImagePicker _picker;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    args = Get.arguments as DataPendukungKorlap;

    if (Get.isRegistered<PendukungKlpController>()) {
      _pendukungKlpC = Get.find<PendukungKlpController>();
    }

    _pendukungS = PendukungServices();
    _picker = ImagePicker();
  }

  Future<void> uploadBuktiLapangan() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);

    try {
      if (file != null) {
        final multipart = await dio.MultipartFile.fromFile(
          file.path,
          filename: file.name,
        );

        final data = dio.FormData.fromMap({
          'pendukungcoblos_tps': multipart,
        });

        final response = await _pendukungS.uploadBuktiLapangan(
          id: args.id!,
          model: data,
        );

        showDialog(
          context: Get.context!,
          builder: (context) => Dialog(
            child: LottieBuilder.asset(ConstantsLottie.loading),
          ),
          barrierDismissible: false,
        );

        if (response.statusCode == HttpStatus.ok) {
          Get.back();
          showSnackBar(
            content: const Text('Berhasil upload bukti lapangan'),
            backgroundColor: Colors.green,
          );
          Get.back();
          _pendukungKlpC.pagingC.refresh();
        } else {
          Get.back();

          showSnackBar(
            content: const Text('Gagal upload bukti lapangan'),
            backgroundColor: Colors.red,
          );
        }
      }
    } on dio.DioException catch (e) {
      logger.e('Error: $e');
      Get.back();

      showSnackBar(
        content: const Text('Gagal upload bukti lapangan'),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> uploadBuktiCoblos() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);

    try {
      if (file != null) {
        final multipart = await dio.MultipartFile.fromFile(
          file.path,
          filename: file.name,
        );

        final data = dio.FormData.fromMap({
          'tps_coblos': multipart,
        });

        final response = await _pendukungS.uploadBuktiCoblos(
          id: args.id!,
          model: data,
        );

        showDialog(
          context: Get.context!,
          builder: (context) => Dialog(
            child: LottieBuilder.asset(ConstantsLottie.loading),
          ),
          barrierDismissible: false,
        );

        if (response.statusCode == HttpStatus.ok) {
          Get.back();
          showSnackBar(
            content: const Text('Berhasil upload bukti coblos'),
            backgroundColor: Colors.green,
          );
          _pendukungKlpC.pagingC.refresh();
          Get.back();
        }
      }
    } on dio.DioException catch (e) {
      logger.e('Error: $e');
      Get.back();
      showSnackBar(
        content: const Text('Berhasil upload bukti coblos'),
        backgroundColor: Colors.green,
      );
    }
  }
}
