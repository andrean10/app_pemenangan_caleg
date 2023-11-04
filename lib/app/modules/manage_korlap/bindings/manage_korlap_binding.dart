import 'package:get/get.dart';

import '../controllers/manage_korlap_controller.dart';

class ManageKorlapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageKorlapController>(() => ManageKorlapController());
  }
}
