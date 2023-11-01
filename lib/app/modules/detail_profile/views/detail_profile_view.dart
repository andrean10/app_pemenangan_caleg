import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_profile_controller.dart';

class DetailProfileView extends GetView<DetailProfileController> {
  const DetailProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
