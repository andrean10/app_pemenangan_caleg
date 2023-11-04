import 'package:get/get.dart';

import '../controllers/suara_tps_kcb_controller.dart';

class SuaraTpsKcbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuaraTpsKcbController>(() => SuaraTpsKcbController());
  }
}
