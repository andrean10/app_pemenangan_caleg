import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_korlap_controller.dart';

class DetailTPSKorlapView extends GetView<DetailTPSKorlapController> {
  const DetailTPSKorlapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget builderContent() {
      return SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [],
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailTPSKorlapView'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: builderContent(),
    );
  }
}
