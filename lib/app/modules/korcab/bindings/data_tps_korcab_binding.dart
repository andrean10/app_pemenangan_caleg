import 'package:get/get.dart';

import '../controllers/data_tps_korcab/data_tps_korcab_controller.dart';
import '../controllers/tps_korlap/tps_korlap_controller.dart';
import '../controllers/tps_pendukung/tps_pendukung_controller.dart';

class DataTpsKorcabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataTpsKorcabController>(() => DataTpsKorcabController());
    Get.lazyPut<TPSKorlapController>(() => TPSKorlapController(), fenix: true);
    Get.lazyPut<TPSPendukungKcbController>(
      () => TPSPendukungKcbController(),
      fenix: true,
    );
  }
}
