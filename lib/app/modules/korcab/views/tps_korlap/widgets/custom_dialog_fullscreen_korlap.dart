import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/tps_korlap/tps_korlap_controller.dart';
import 'builder_list_content_korlap.dart';

class CustomDialogFullscreenKorlap extends GetView<TPSKorlapController> {
  final String title;
  final bool isEdit;
  final int? id;

  const CustomDialogFullscreenKorlap({
    required this.title,
    required this.isEdit,
    this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close_rounded),
          ),
        ),
        body: const BuilderListContentKorlap(isEdit: true),
        floatingActionButton: Obx(
          () => AnimatedOpacity(
            opacity: controller.dataUsersSelected.isNotEmpty ? 1 : 0,
            duration: 300.milliseconds,
            child: FloatingActionButton(
              onPressed: () {
                if (isEdit) {
                  controller.editCo(
                    id!,
                    controller.dataUsersSelected.first.id!,
                  );
                } else {
                  controller.addCo(controller.args.id!);
                }
              },
              child: const Icon(Icons.check_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
