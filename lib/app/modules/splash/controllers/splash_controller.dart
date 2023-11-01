import 'package:app_pemenangan_caleg/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../init/controller/init_controller.dart';

class SplashController extends GetxController {
  late final InitController _initC;

  @override
  void onReady() {
    super.onReady();

    _initController();
    Future.delayed(
      const Duration(seconds: 3),
      () => checkSession(),
    );
  }

  void _initController() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }
  }

  Future<void> checkSession() async {
    final session = await _initC.getSession();

    if (session != null) {
      if (session.role.toLowerCase() == 'koordinator') {
        Get.offAllNamed(Routes.KORLAP);
      } else {
        Get.offAllNamed(Routes.KORCAB);
      }
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
