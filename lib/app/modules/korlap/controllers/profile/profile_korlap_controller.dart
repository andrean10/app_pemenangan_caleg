import 'dart:io';

import 'package:app_pemenangan_caleg/app/data/models/users/response_users_model.dart';
import 'package:app_pemenangan_caleg/app/data/models/users/users_model.dart';
import 'package:app_pemenangan_caleg/app/modules/init/controller/init_controller.dart';
import 'package:app_pemenangan_caleg/app/services/profile/profile_services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../routes/app_pages.dart';

class ProfileKorlapController extends GetxController {
  late final InitController _initC;
  late final ProfileServices _profileS;

  final usersModel = Rxn<UsersModel>();

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    _profileS = ProfileServices();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final response = await _profileS.fetchProfile();
      if (response.statusCode == HttpStatus.ok) {
        final data = ResponseUsersModel.fromJson(response.data);
        final result = data.result;
        usersModel.value = result;
      }
    } catch (e) {
      logger.e('Error: $e');
    }
  }

  void moveToDetail() => Get.toNamed(Routes.DETAIL_PROFILE);

  void logout() {
    _initC.deleteSession().then(
          (value) => Get.offAllNamed(Routes.LOGIN),
        );
  }
}
