import 'package:get/get.dart';

import '../controller/init_controller.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InitController>(InitController(), permanent: true);
  }
}
