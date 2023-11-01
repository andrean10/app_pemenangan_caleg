import 'package:app_pemenangan_caleg/app/modules/korcab/views/home/home_view.dart';
import 'package:app_pemenangan_caleg/app/modules/korcab/views/korlap/korlap_kcb_view.dart';
import 'package:app_pemenangan_caleg/app/modules/korcab/views/pendukung/pendukung_kcb_view.dart';
import 'package:app_pemenangan_caleg/app/modules/korcab/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/korcab_controller.dart';

class KorcabView extends GetView<KorcabController> {
  const KorcabView({Key? key}) : super(key: key);

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
          icon: Icon(Icons.supervisor_account_outlined),
          selectedIcon: Icon(Icons.supervisor_account_rounded),
          label: 'Koordinator',
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
            HomeView(),
            PendukungKcbView(),
            KorlapKcbView(),
            ProfileView(),
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
