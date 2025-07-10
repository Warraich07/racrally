import 'package:get/get.dart';

class TeamController extends GetxController {
  RxBool isTeamCreated=false.obs;
  RxBool isPlayerInvited=false.obs;
  RxBool isActiveRoaster=false.obs;
  void toggleRoaster(){
    isActiveRoaster.value=!isActiveRoaster.value;
  }

}
