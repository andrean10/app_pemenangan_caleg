import 'package:app_pemenangan_caleg/app/modules/korcab/views/tps_pendukung/widgets/custom_dialog_fullscreen_tps_pendukung.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/tps_pendukung/tps_pendukung_controller.dart';
import 'widgets/builder_content_tps_pendukung.dart';

class TPSPendukungKcbView extends GetView<TPSPendukungKcbController> {
  const TPSPendukungKcbView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Widget> showCustomFullDialog({
      required BuildContext context,
      required String title,
    }) async {
      return await showDialog(
        context: context,
        builder: (context) => CustomDialogFullscreenTpsPendukung(
          title: title,
          isEdit: false,
        ),
      ).whenComplete(
        () => controller.clearDataSelected(),
      );
    }

    Widget builderFAB() {
      return Obx(
        () => AnimatedOpacity(
          duration: 300.milliseconds,
          opacity: controller.isScrolling.value ? 0 : 1,
          child: FloatingActionButton(
            onPressed: () => showCustomFullDialog(
              context: context,
              title: 'Pilih Pendukung',
            ),
            child: const Icon(Icons.add_rounded),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data TPS Pendukung'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: const BuilderContentTpsPendukung(),
      floatingActionButton: builderFAB(),
    );
  }
}
