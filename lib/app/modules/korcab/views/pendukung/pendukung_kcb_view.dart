import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/pendukung/pendukung_kcb_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/builder_content_pendukung_kcb.dart';

class PendukungKcbView extends GetView<PendukungKcbController> {
  const PendukungKcbView({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget builderFAB() {
    //   return Obx(
    //     () => AnimatedOpacity(
    //       duration: 300.milliseconds,
    //       opacity: controller.isScrolling.valupe ? 0 : 1,
    //       child: FloatingActionButton(
    //         onPressed: () {},
    //         child: const Icon(Icons.add_rounded),
    //       ),
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pendukung'),
        centerTitle: true,
      ),
      body: const BuilderContentPendukungKcb(),
    );
  }
}
