import 'package:get/get.dart';

import '../controllers/manage_pendukung_by_korlap_controller.dart';

class ManagePendukungByKorlapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagePendukungByKorlapController>(
      () => ManagePendukungByKorlapController(),
    );
  }
}
