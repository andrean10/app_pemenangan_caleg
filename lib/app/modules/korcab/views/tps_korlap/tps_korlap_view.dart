import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/tps_korlap/tps_korlap_controller.dart';
import 'widgets/builder_content_korlap.dart';
import 'widgets/custom_dialog_fullscreen_korlap.dart';

class TPSKorlapView extends GetView<TPSKorlapController> {
  const TPSKorlapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Widget> showCustomFullDialog({
      required BuildContext context,
      required String title,
    }) async {
      return await showDialog(
        context: context,
        builder: (context) => CustomDialogFullscreenKorlap(
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
              title: 'Pilih Koordinator',
            ),
            child: const Icon(Icons.add_rounded),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Koordinator'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: const BuilderContentKorlap(),
      floatingActionButton: builderFAB(),
    );
  }
}
