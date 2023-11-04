import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/korlap/korlap_kcb_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/builder_content_korlap_kcb.dart';

class KorlapKcbView extends GetView<KorlapKcbController> {
  const KorlapKcbView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget builderFAB() {
      return Obx(
        () => AnimatedOpacity(
          duration: 300.milliseconds,
          opacity: controller.isScrolling.value ? 0 : 1,
          child: FloatingActionButton(
            onPressed: controller.moveToManageKorlap,
            child: const Icon(Icons.add_rounded),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Koordinator'),
        centerTitle: true,
      ),
      body: const BuilderContentKorlapKcb(),
      floatingActionButton: builderFAB(),
    );
  }
}
