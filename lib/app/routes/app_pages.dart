import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login/login_view.dart';
import '../modules/data_pendukung_korlap/views/data_pendukung_korlap_view.dart';
import '../modules/detail_korlap/bindings/detail_korlap_binding.dart';
import '../modules/detail_korlap/views/detail_korlap_view.dart';
import '../modules/detail_profile/bindings/detail_profile_binding.dart';
import '../modules/detail_profile/views/detail_profile_view.dart';
import '../modules/korcab/bindings/data_tps_korcab_binding.dart';
import '../modules/korcab/bindings/korcab_binding.dart';
import '../modules/korcab/views/data_tps/data_tps_korcab_view.dart';
import '../modules/korcab/views/korcab_view.dart';
import '../modules/korcab/views/tps_korlap/tps_korlap_view.dart';
import '../modules/korcab/views/tps_pendukung/tps_pendukung_view.dart';
import '../modules/korlap/bindings/detail_pendukung_klp_binding.dart';
import '../modules/korlap/bindings/korlap_binding.dart';
import '../modules/korlap/views/korlap_view.dart';
import '../modules/korlap/views/pendukung/detail/detail_pendukung_klp_view.dart';
import '../modules/manage_korlap/bindings/manage_korlap_binding.dart';
import '../modules/manage_korlap/views/manage_korlap_view.dart';
import '../modules/manage_pendukung_by_korlap/bindings/manage_pendukung_by_korlap_binding.dart';
import '../modules/manage_pendukung_by_korlap/views/manage_pendukung_by_korlap_view.dart';
import '../modules/manage_profile/bindings/manage_profile_binding.dart';
import '../modules/manage_profile/views/manage_profile_view.dart';
import '../modules/manage_tps_korcab/bindings/manage_tps_korcab_binding.dart';
import '../modules/manage_tps_korcab/views/manage_tps_korcab_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/suara_tps_kcb/bindings/suara_tps_kcb_binding.dart';
import '../modules/suara_tps_kcb/views/suara_tps_kcb_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.KORCAB,
      page: () => const KorcabView(),
      binding: KorcabBinding(),
      children: [
        GetPage(
          name: _Paths.DATA_TPS_KORCAB,
          page: () => const DataTpsKorcabView(),
          binding: DataTpsKorcabBinding(),
          children: [
            GetPage(
              name: _Paths.TPS_KORLAP,
              page: () => const TPSKorlapView(),
            ),
            GetPage(
              name: _Paths.TPS_PENDUKUNG,
              page: () => const TPSPendukungKcbView(),
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: _Paths.MANAGE_TPS_KORCAB,
      page: () => const ManageDataTpsKorcabView(),
      binding: ManageTpsKorcabBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_KORLAP,
      page: () => const DetailTPSKorlapView(),
      binding: DetailKorlapBinding(),
    ),
    GetPage(
      name: _Paths.KORLAP,
      page: () => const KorlapView(),
      binding: KorlapBinding(),
      children: [
        GetPage(
          name: _Paths.DETAIL_PENDUKUNG_KLP,
          page: () => const DetailPendukungKlpView(),
          binding: DetailPendukungKlpBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.DATA_PENDUKUNG_KORLAP,
      page: () => const DataPendukungKorlapView(),
    ),
    GetPage(
      name: _Paths.DETAIL_PROFILE,
      page: () => const DetailProfileKorcabView(),
      binding: DetailProfileBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_KORLAP,
      page: () => const ManageKorlapView(),
      binding: ManageKorlapBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_PENDUKUNG_BY_KORLAP,
      page: () => const ManagePendukungByKorlapView(),
      binding: ManagePendukungByKorlapBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_PROFILE,
      page: () => const ManageProfileView(),
      binding: ManageProfileBinding(),
    ),
    GetPage(
      name: _Paths.SUARA_TPS_KCB,
      page: () => const SuaraTpsKcbView(),
      binding: SuaraTpsKcbBinding(),
    ),
  ];
}
