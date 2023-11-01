import 'dart:io';

import 'package:get/get.dart';

import '../../../data/models/users/profile_model.dart';
import '../../../services/profile/profile_services.dart';

class DetailProfileController extends GetxController {
  late ProfileServices _profileS;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    _profileS = ProfileServices();
  }

  Future<void> fetchDetailProfile() async {
    try {
      final response = await _profileS.fetchProfile();
      if (response.statusCode == HttpStatus.ok) {
        final data = ProfileModel.fromJson(response.data);
        print(data);
      }
    } catch (e) {
      print(e);
    }
  }
}
