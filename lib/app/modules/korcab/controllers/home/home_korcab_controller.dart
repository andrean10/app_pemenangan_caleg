import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/korcab_controller.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class HomeKorcabController extends GetxController {
  late KorcabController korcabC;

  @override
  void onInit() {
    super.onInit();
    _onInit();
  }

  void _onInit() {
    if (Get.isRegistered<KorcabController>()) {
      korcabC = Get.find<KorcabController>();
    }
  }

  void moveToDataTPS() => Get.toNamed(
        '${Get.currentRoute}${Routes.DATA_TPS_KORCAB}',
      );
}
