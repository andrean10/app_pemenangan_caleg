import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/tps_pendukung/tps_pendukung_controller.dart';
import 'package:app_pemenangan_caleg/app/modules/korcab/views/tps_pendukung/widgets/builder_list_content_tps_pendukung.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogFullscreenTpsPendukung
    extends GetView<TPSPendukungKcbController> {
  final String title;
  final bool isEdit;
  final int? id;

  const CustomDialogFullscreenTpsPendukung({
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
        body: BuilderListContentTpsPendukung(isEdit: isEdit),
        floatingActionButton: Obx(
          () => AnimatedOpacity(
            opacity: controller.dataUsersSelected.isNotEmpty ? 1 : 0,
            duration: 300.milliseconds,
            child: FloatingActionButton(
              onPressed: () {
                if (isEdit) {
                  controller.editPendukung(
                    id: id!,
                    userId: controller.dataUsersSelected.first.id!,
                  );
                } else {
                  controller.addPendukung();
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
