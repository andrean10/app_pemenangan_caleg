import 'package:get/get.dart';

import '../controllers/detail_korlap_controller.dart';

class DetailKorlapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTPSKorlapController>(
      () => DetailTPSKorlapController(),
    );
  }
}
