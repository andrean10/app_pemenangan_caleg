import 'package:app_pemenangan_caleg/app/modules/init/controller/init_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  late final InitController _initC;
  final selectedImage = Rxn<XFile>();

  var tappedYes = false;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }
  }

  void logout() {
    _initC.deleteSession().then(
          (value) => Get.offAllNamed(Routes.LOGIN),
        );
  }
}
