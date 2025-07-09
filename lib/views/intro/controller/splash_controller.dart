import 'dart:async';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final RxDouble progress = 0.0.obs;
  Timer? _timer;

  void startProgressTimer() {
    const totalDuration = Duration(seconds: 2);
    const tick = Duration(milliseconds: 30);
    final step = tick.inMilliseconds / totalDuration.inMilliseconds;

    _timer = Timer.periodic(tick, (timer) {
      progress.value += step;
      if (progress.value >= 1.0) {
        progress.value = 1.0;
        timer.cancel();
        Get.offNamed(AppRoutes.onboarding);
        // Get.offAndToNamed(AppRoutes.bottomBar);
        // Optional: Navigate to another screen
        // Get.off(() => const HomeScreen());
      }
    });
  }

}
