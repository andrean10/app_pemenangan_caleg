import 'package:get/get.dart';

import '../controllers/pendukung/detail/detail_pendukung_klp_controller.dart';

class DetailPendukungKlpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPendukungKlpController>(
      () => DetailPendukungKlpController(),
    );
  }
}
