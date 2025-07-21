import 'package:get/get.dart';

class SeasonController extends GetxController {
  final RxInt selectedToggleIndex = 0.obs;

  void toggleTab(int index) {
    selectedToggleIndex.value = index;
  }
}
