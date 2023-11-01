import 'package:app_pemenangan_caleg/app/modules/korlap/views/suara_tps/suara_tps_klp_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/korlap_controller.dart';
import 'home/home_korlap_view.dart';
import 'pendukung/pendukung_klp_view.dart';
import 'profile/profile_korlap_view.dart';

class KorlapView extends GetView<KorlapController> {
  const KorlapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> builderDestination() {
      return [
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        const NavigationDestination(
          icon: Icon(Icons.group_outlined),
          selectedIcon: Icon(Icons.group_rounded),
          label: 'Pendukung',
        ),
        const NavigationDestination(
          icon: Icon(Icons.pie_chart_outline_rounded),
          selectedIcon: Icon(Icons.pie_chart_rounded),
          label: 'Suara TPS',
        ),
        const NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ];
    }

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomeKorlapView(),
            PendukungKlpView(),
            SuaraTpsKlpView(),
            ProfileKorlapView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.setCurentIndex,
          destinations: builderDestination(),
        ),
      ),
    );
  }
}
