import 'dart:convert';
import 'package:get/get.dart';
import 'package:racrally/models/sent_invites_model.dart';
import 'package:racrally/models/team_model.dart';

import '../../../api_services/api_exceptions.dart';
import '../../../api_services/data_api.dart';
import '../../../controllers/base_controller.dart';
import '../../../models/my_invites_model.dart';
import '../../../utils/snackbar_utils.dart';

class TeamController extends GetxController {
  RxBool isTeamCreated=false.obs;
  RxBool isPlayerInvited=false.obs;
  RxBool isActiveRoaster=false.obs;
  RxBool isLoading=false.obs;
  final BaseController _baseController = BaseController.instance;
  Rxn<TeamModel> teamData=Rxn<TeamModel>();
  RxList<TeamModel> teamList=<TeamModel>[].obs;
  RxList<SentInvitesModel> sentInvitesList=<SentInvitesModel>[].obs;
  RxList<MyInvitesModel> myInvitesList=<MyInvitesModel>[].obs;


  Future sendInvite(String teamId,String email,String role) async {
    _baseController.showLoading();
    Map<String, String> body = {
      "id":teamId,
      "email":email,
      "role":role
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
      getTeam();
      Get.back();
      SnackbarUtil.showSnackbar(message: "Invite Sent", type: SnackbarType.success);

      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future getSentInvites(String teamId) async {
    isLoading.value=true;

    print("get-team");
    var response = await DataApiService.instance
        .get("/team/invites/$teamId")
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        SnackbarUtil.showSnackbar(message: "Bad Request", type: SnackbarType.error);
      } else {
        _baseController.handleError(error);
      }
    });
    isLoading.value=false;
    update();
    if (response == null) return;
    print(response + " responded");
    var result = json.decode(response);
    isLoading.value=false;
    if (result['success'].toString()=="true") {
      final data = result['data'];

      // ✅ Check if data is List
      if (data is List) {
        // sentInvitesList.value = List<SentInvitesModel>.from(result['data'].map((x) => SentInvitesModel.fromJson(x)));

        sentInvitesList.value = List<SentInvitesModel>.from(
          data.map((x) => SentInvitesModel.fromJson(x)),
        );
        if(sentInvitesList.isNotEmpty){
          isPlayerInvited.value=true;
        }
      } else {
        // Optional: handle if data is not a list
        sentInvitesList.clear();
      }
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future getMyInvites() async {
    isLoading.value=true;

    print("get-team");
    var response = await DataApiService.instance
        .get("/team/my-invites")
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        SnackbarUtil.showSnackbar(message: "Bad Request", type: SnackbarType.error);
      } else {
        _baseController.handleError(error);
      }
    });
    isLoading.value=false;
    update();
    if (response == null) return;
    print(response + " responded");
    var result = json.decode(response);
    isLoading.value=false;
    if (result['success'].toString()=="true") {
      final data = result['data'];
      if (data is List) {

        myInvitesList.value = List<MyInvitesModel>.from(
          data.map((x) => MyInvitesModel.fromJson(x)),
        );
      }
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }
  
  Future getTeam() async {
    isLoading.value=true;

print("get-team");
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
      getSentInvites(teamList[0].id.toString());
      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future deleteTeam(String teamId) async {
    _baseController.showLoading();
    print("get-team");
    var response = await DataApiService.instance
        .delete("/team/$teamId")
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
          getTeam();
          SnackbarUtil.showSnackbar(message: "Team Deleted", type: SnackbarType.success);
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

  Future editTeam(String teamId, String teamName, String location, String color, String imagePath) async {
    _baseController.showLoading();

    Map<String, String> body = {
      'name': teamName,
      'location': location,
      'color': color
    };

    var response;

    if (imagePath.isNotEmpty) {
      // ✅ Corrected: Use PUT for multipart update
      response = await DataApiService.instance
          .multiPartImagePut('/team/$teamId', [imagePath], "image", body)
          .catchError((error) {
        if (error is BadRequestException) {
          SnackbarUtil.showSnackbar(message: "Bad Request", type: SnackbarType.error);
        } else {
          _baseController.handleError(error);
        }
      });
    } else {
      // No image: use regular PUT
      response = await DataApiService.instance
          .put('/team/$teamId', body)
          .catchError((error) {
        if (error is BadRequestException) {
          SnackbarUtil.showSnackbar(message: "Bad Request", type: SnackbarType.error);
        } else {
          _baseController.handleError(error);
        }
      });
    }

    update();
    _baseController.hideLoading();

    if (response == null) return;

    var result = json.decode(response);
    if (result['success'].toString() == "true") {
      isTeamCreated.value = true;
      teamList.value = [TeamModel.fromJson(result['data'])];
      Get.back();
      SnackbarUtil.showSnackbar(message: "Team Updated", type: SnackbarType.success);
    } else if (result['status'].toString() == "failed" && result['error'].toString() == "true") {
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  void toggleRoaster(){
    isActiveRoaster.value=!isActiveRoaster.value;
  }

}
