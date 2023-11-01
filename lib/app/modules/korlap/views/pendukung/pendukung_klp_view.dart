import 'package:app_pemenangan_caleg/app/modules/korlap/controllers/pendukung/pendukung_klp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/builder_content_pendukung_klp.dart';

class PendukungKlpView extends GetView<PendukungKlpController> {
  const PendukungKlpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendukung'),
        centerTitle: true,
      ),
      body: const BuilderContentPendukungKlp(),
    );
  }
}
