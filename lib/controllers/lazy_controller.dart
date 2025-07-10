import 'package:get/get.dart';
import 'package:racrally/views/auth/controller/auth_controller.dart';
import 'package:racrally/views/intro/controller/splash_controller.dart';
import '../views/bottom_nav_bar/controller/bottom_bar_controller.dart';
import '../views/events/controller/event_controller.dart';
import '../views/team/controller/team_controller.dart';

class LazyController extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(TeamController());
    Get.put(EventController());
    Get.put(GeneralController());
    Get.put(SplashController());
    Get.put(AuthController());
  }
}