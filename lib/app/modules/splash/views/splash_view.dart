import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 1 / 4,
          child: Image(
            image: AssetImage('assets/img/logo.png'),
          ),
        ),
      ),
    );
  }
}
