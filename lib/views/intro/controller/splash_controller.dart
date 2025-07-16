import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/local_storage/shared_preferences.dart';
import '../../auth/controller/auth_controller.dart';

class SplashController extends GetxController {
  final RxDouble progress = 0.0.obs;
  Timer? _timer;
  Rxn<UserModel> userData=Rxn<UserModel>();

  
  maintainSessionAndNavigate() async {

    Map<String, dynamic> userStatus = await AuthPreference.instance.getUserLoggedIn();
    bool isFirstTIme = await AuthPreference.instance.getFirstTime();
    bool isLoggedIn = userStatus["isLoggedIn"];

    if (isLoggedIn==true) {
      Get.put(AuthController()).accessToken.value = await AuthPreference.instance.getUserDataToken();
      var userData = await AuthPreference.instance.getUserData();
      print(userData);
      Get.put(AuthController()).userData.value = UserModel.fromJson(jsonDecode(userData));
      startProgressTimer(true,isFirstTIme);
    }else if(isLoggedIn==false){
      startProgressTimer(false,isFirstTIme);
    }else{

    }
  }

  void startProgressTimer(bool isLoggedIn,bool isFirstTime) {
    const totalDuration = Duration(seconds: 2);
    const tick = Duration(milliseconds: 30);
    final step = tick.inMilliseconds / totalDuration.inMilliseconds;

    _timer = Timer.periodic(tick, (timer) {
      progress.value += step;
      if (progress.value >= 1.0) {
        progress.value = 1.0;
        timer.cancel();
        if(isLoggedIn){
          Get.offAndToNamed(AppRoutes.bottomBar);
        }else if(isLoggedIn==false&&isFirstTime==true){
          Get.offNamed(AppRoutes.onboarding);
        }else{
          // Get.offAndToNamed(AppRoutes.bottomBar);
          Get.offNamed(AppRoutes.login);
        }
        // Get.offAndToNamed(AppRoutes.bottomBar);
        // Optional: Navigate to another screen
        // Get.off(() => const HomeScreen());
      }
    });
  }

}
