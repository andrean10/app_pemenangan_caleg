import 'package:app_pemenangan_caleg/app/modules/data_pendukung_korlap/views/widgets/builder_content_data_pendukung_klp.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/data_pendukung_korlap_controller.dart';

class DataPendukungKorlapView extends GetView<DataPendukungKorlapController> {
  const DataPendukungKorlapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pendukung'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: const BuilderContentDataPendukungKlp(),
    );
  }
}
