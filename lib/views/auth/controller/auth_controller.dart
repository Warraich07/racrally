import 'package:get/get.dart';


class AuthController extends GetxController {
  RxString accessToken = "".obs;
  RxBool showCheck=false.obs;
  RxBool showPassword=false.obs;
  RxString checkedItem = ''.obs;

  void setCheck(String? value) {
    checkedItem.value = value ?? '';
  }
  void toggleCheck(){
    showCheck.value=!showCheck.value;
  }

  void togglePassword(){
    showPassword.value=!showPassword.value;
  }


}