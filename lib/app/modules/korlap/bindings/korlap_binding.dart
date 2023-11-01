import 'package:app_pemenangan_caleg/app/modules/korlap/controllers/pendukung/pendukung_klp_controller.dart';
import 'package:app_pemenangan_caleg/app/modules/korlap/controllers/profile/profile_korlap_controller.dart';
import 'package:app_pemenangan_caleg/app/modules/korlap/controllers/suara_tps/suara_tps_klp_controller.dart';
import 'package:get/get.dart';

import '../controllers/home/home_korlap_controller.dart';
import '../controllers/korlap_controller.dart';

class KorlapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KorlapController>(() => KorlapController());

    Get.lazyPut<HomeKorlapController>(() => HomeKorlapController());
    Get.lazyPut<PendukungKlpController>(() => PendukungKlpController());
    Get.lazyPut<SuaraTpsKlpController>(() => SuaraTpsKlpController());
    Get.lazyPut<ProfileKorlapController>(() => ProfileKorlapController());
  }
}
