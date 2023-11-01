import 'package:get/get.dart';

class KorcabController extends GetxController {
  final currentIndex = 0.obs;

  void setCurentIndex(int index) => currentIndex.value = index;
}
