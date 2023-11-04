import 'dart:io';

import 'package:app_pemenangan_caleg/app/modules/korlap/controllers/korlap_controller.dart';
import 'package:app_pemenangan_caleg/app/services/profile/profile_services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/users/response_users_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../routes/app_pages.dart';

class HomeKorlapController extends GetxController {
  late KorlapController korlapC;
  late ProfileServices _profileS;
  final usersModel = Rxn<UsersModel>();

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _onInit();
  }

  void _onInit() {
    if (Get.isRegistered<KorlapController>()) {
      korlapC = Get.find<KorlapController>();
    }

    _profileS = ProfileServices();
    fetchProfile();
  }

  Future<UsersModel?> fetchProfile() async {
    try {
      final response = await _profileS.fetchProfile();
      if (response.statusCode == HttpStatus.ok) {
        final data = ResponseUsersModel.fromJson(response.data);
        usersModel.value = data.result;
        return data.result;
      }
    } catch (e) {
      logger.e('Error: $e');
    }

    return null;
  }

  void moveToDataPendukung() => Get.toNamed(
        Routes.DATA_PENDUKUNG_KORLAP,
      );
}
