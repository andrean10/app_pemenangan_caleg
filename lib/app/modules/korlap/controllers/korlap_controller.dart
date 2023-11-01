import 'package:get/get.dart';

class KorlapController extends GetxController {
  final currentIndex = 0.obs;

  void setCurentIndex(int index) => currentIndex.value = index;
}
