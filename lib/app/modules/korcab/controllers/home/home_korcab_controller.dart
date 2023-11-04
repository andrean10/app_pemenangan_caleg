import 'dart:io';

import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/korcab_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/users/response_users_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/profile/profile_services.dart';

class HomeKorcabController extends GetxController {
  late KorcabController korcabC;
  late ProfileServices _profileS;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _onInit();
  }

  void _onInit() {
    if (Get.isRegistered<KorcabController>()) {
      korcabC = Get.find<KorcabController>();
    }

    _profileS = ProfileServices();
  }

  Future<UsersModel?> fetchProfile() async {
    try {
      final response = await _profileS.fetchProfile();
      if (response.statusCode == HttpStatus.ok) {
        final data = ResponseUsersModel.fromJson(response.data);
        return data.result;
      }
    } catch (e) {
      logger.e('Error: $e');
    }

    return null;
  }

  void moveToDataTPS() => Get.toNamed(
        '${Get.currentRoute}${Routes.DATA_TPS_KORCAB}',
      );

  void moveToSuaraTPS() => Get.toNamed(Routes.SUARA_TPS_KCB);
}
