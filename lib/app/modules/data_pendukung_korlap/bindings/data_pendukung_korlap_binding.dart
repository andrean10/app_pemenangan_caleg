import 'package:get/get.dart';

import '../controllers/data_pendukung_korlap_controller.dart';

class DataPendukungKorlapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataPendukungKorlapController>(
      () => DataPendukungKorlapController(),
    );
  }
}
