import 'dart:convert';
import 'package:get/get.dart';
import 'package:racrally/models/team_model.dart';

import '../../../api_services/api_exceptions.dart';
import '../../../api_services/data_api.dart';
import '../../../controllers/base_controller.dart';
import '../../../utils/snackbar_utils.dart';

class TeamController extends GetxController {
  RxBool isTeamCreated=false.obs;
  RxBool isPlayerInvited=false.obs;
  RxBool isActiveRoaster=false.obs;
  RxBool isLoading=false.obs;
  final BaseController _baseController = BaseController.instance;
  Rxn<TeamModel> teamData=Rxn<TeamModel>();
  RxList<TeamModel> teamList=<TeamModel>[].obs;

  Future sendInvite(String email,String role) async {
    _baseController.showLoading();
    Map<String, String> body = {
      "teamId":teamList[0].id.toString(),
      "email":email,
      "role":role,
      "resend" : "false"
    };

    var response = await DataApiService.instance
        .post("/team/send-invite", body)
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        SnackbarUtil.showSnackbar(message: "Bad Request", type: SnackbarType.error);
      } else {
        _baseController.handleError(error);
      }
    });

    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response + " responded");

    var result = json.decode(response);
    if (result['success'].toString()=="true") {
      isPlayerInvited.value=true;
      // teamList.value = [TeamModel.fromJson(result['data'])];
      Get.back();
      SnackbarUtil.showSnackbar(message: "Invite Sent", type: SnackbarType.success);

      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }
  
  Future getTeam() async {
    isLoading.value=true;


    var response = await DataApiService.instance
        .get("/team")
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        SnackbarUtil.showSnackbar(message: "Bad Request", type: SnackbarType.error);
      } else {
        _baseController.handleError(error);
      }
    });

    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response + " responded");
    var result = json.decode(response);
    isLoading.value=false;
    if (result['success'].toString()=="true") {
      final rawData = result['data'];

      List teams = [];

      if (rawData is List) {
        teams = rawData;
      } else if (rawData is Map && rawData['teams'] is List) {
        teams = rawData['teams'];
      }

      teamList.value = List<TeamModel>.from(
          teams.map((x) => TeamModel.fromJson(x))
      );

      isTeamCreated.value = teamList.isNotEmpty;

      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future createTeam(String teamName,String location,String color,String imagePath) async {
    _baseController.showLoading();
    Map<String, String> body = {
      'name': teamName,
      'location': location,
      'color': color
    };

    var response = await DataApiService.instance
        .multiPartImage('/team',[imagePath],"image",body)
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        SnackbarUtil.showSnackbar(message: "Bad Request", type: SnackbarType.error);
      } else {
        _baseController.handleError(error);
      }
    });

    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response + " responded");

    var result = json.decode(response);
    if (result['success'].toString()=="true") {
      isTeamCreated.value=true;
      teamList.value = [TeamModel.fromJson(result['data'])];
      Get.back();
      SnackbarUtil.showSnackbar(message: "Team Created", type: SnackbarType.success);

      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  void toggleRoaster(){
    isActiveRoaster.value=!isActiveRoaster.value;
  }

}
