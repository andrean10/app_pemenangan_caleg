import 'package:get/get.dart';

import '../controllers/manage_tps_korcab_controller.dart';

class ManageTpsKorcabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageDataTpsKorcabController>(
      () => ManageDataTpsKorcabController(),
    );
  }
}
