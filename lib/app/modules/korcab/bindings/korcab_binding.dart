import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/pendukung/pendukung_kcb_controller.dart';
import 'package:get/get.dart';

import '../controllers/home/home_korcab_controller.dart';
import '../controllers/korlap/korlap_kcb_controller.dart';
import '../controllers/profile/profile_controller.dart';
import '../controllers/korcab_controller.dart';

class KorcabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KorcabController>(() => KorcabController());

    Get.lazyPut<HomeKorcabController>(() => HomeKorcabController());
    Get.lazyPut<PendukungKcbController>(() => PendukungKcbController());
    Get.lazyPut<KorlapKcbController>(() => KorlapKcbController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
