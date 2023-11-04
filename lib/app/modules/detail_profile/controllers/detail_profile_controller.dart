import 'dart:io';

import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/profile/profile_korcab_controller.dart';
import 'package:app_pemenangan_caleg/app/modules/korlap/controllers/profile/profile_korlap_controller.dart';
import 'package:app_pemenangan_caleg/app/services/profile/profile_services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/models/users/response_users_model.dart';
import '../../../data/models/users/users_model.dart';
import '../../../routes/app_pages.dart';

class DetailProfileKorcabController extends GetxController {
  late ProfileServices _profileS;
  late ProfileKorcabController _profileKorcabC;
  late ProfileKorlapController _profileKorlapC;

  final dataUsers = Rxn<UsersModel>();

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    _profileS = ProfileServices();

    if (Get.isRegistered<ProfileKorcabController>()) {
      _profileKorcabC = Get.find<ProfileKorcabController>();
    }

    if (Get.isRegistered<ProfileKorlapController>()) {
      _profileKorlapC = Get.find<ProfileKorlapController>();
    }

    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final response = await _profileS.fetchProfile();
      if (response.statusCode == HttpStatus.ok) {
        final data = ResponseUsersModel.fromJson(response.data);
        dataUsers.value = data.result;

        logger.d(
            'debug: isProfileKorcab initialized = ${_profileKorcabC.initialized}');
        logger.d(
            'debug: isProfileKorlap initialized = ${_profileKorlapC.initialized}');

        if (_profileKorcabC.initialized) {
          _profileKorcabC.fetchProfile();
        }

        if (_profileKorlapC.initialized) {
          _profileKorlapC.fetchProfile();
        }
      }
    } catch (e) {
      logger.e('Error: $e');
    }
  }

  Future<void> moveToManageProfile() async {
    Get.toNamed(
      Routes.MANAGE_PROFILE,
      arguments: dataUsers.value,
    );
  }
}
