import 'package:get/get.dart';


class AuthController extends GetxController {
  RxString accessToken = "".obs;
  RxBool showCheck=false.obs;
  RxBool showPassword=false.obs;
  void toggleCheck(){
    showCheck.value=!showCheck.value;
  }

  void togglePassword(){
    showPassword.value=!showPassword.value;
  }


}