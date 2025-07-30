import 'dart:convert';
import 'package:get/get.dart';
import 'package:racrally/models/my_event_invites_model.dart';
import 'package:racrally/models/my_team_invites_model.dart';
import 'package:racrally/models/sent_invites_model.dart';
import 'package:racrally/models/team_model.dart';
import '../../../api_services/api_exceptions.dart';
import '../../../api_services/data_api.dart';
import '../../../controllers/base_controller.dart';
import '../../../utils/snackbar_utils.dart';

class TeamController extends GetxController {
  RxBool isTeamCreated=false.obs;
  RxBool isPlayerInvited=false.obs;
  RxBool isActiveRoaster=true.obs;
  RxBool isLoading=false.obs;
  final BaseController _baseController = BaseController.instance;
  Rxn<TeamModel> teamData=Rxn<TeamModel>();
  RxList<TeamModel> teamList=<TeamModel>[].obs;
  RxList<SentInvitesModel> sentInvitesList=<SentInvitesModel>[].obs;
  RxList<MyTeamInvitesModel> myTeamInvitesList=<MyTeamInvitesModel>[].obs;
  RxList<MyEventInvitesModel> myEventInvitesList=<MyEventInvitesModel>[].obs;
  final RxInt selectedToggleIndex = 0.obs;

  void toggleTab(int index) {
    selectedToggleIndex.value = index;
  }

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

  Future reSendInvite(String userId) async {
    _baseController.showLoading();

    var response = await DataApiService.instance
        .put("/team/resend-invite/$userId",{})
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
      if(teamList.isNotEmpty){
        getSentInvites(teamList[0].id.toString());
      }
      Get.back();
      SnackbarUtil.showSnackbar(message: "Invite Re-Sent", type: SnackbarType.success);

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
        }else{
          isPlayerInvited.value=false;
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

      // ✅ Parse teamInvites
      if (data['teamInvites'] != null) {
        myTeamInvitesList.value = List<MyTeamInvitesModel>.from(
          data['teamInvites'].map((item) => MyTeamInvitesModel.fromJson(item)),
        );
      }

      // ✅ Parse eventInvites
      if (data['eventInvites'] != null) {
        myEventInvitesList.value = List<MyEventInvitesModel>.from(
          data['eventInvites'].map((item) => MyEventInvitesModel.fromJson(item)),
        );
      }

    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future changeInviteStatus(String status,String id,bool isAccepted) async {
    _baseController.showLoading();
    print("/team/set-invite");
    Map<String, String> body = {
      // "status" : status,
      "id" : id,
      "isAccepted":isAccepted?'accepted':'rejected'
    };
    var response = await DataApiService.instance
        .post("/team/set-invite",body)
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        SnackbarUtil.showSnackbar(message: "Bad Request", type: SnackbarType.error);
      } else {
        _baseController.handleError(error);
      }
    });
    _baseController.hideLoading();
    update();
    if (response == null) return;
    print(response + " responded");
    var result = json.decode(response);
    isLoading.value=false;
    if (result['success'].toString()=="true") {
        Get.back();
        if(status=="accepted"){
          SnackbarUtil.showSnackbar(message: "Invite Accepted", type: SnackbarType.success);
        }else{
          SnackbarUtil.showSnackbar(message: "Invite rejected", type: SnackbarType.success);

        }
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future removeMemberFromTeam(String userId,String teamID) async {
    _baseController.showLoading();
    print("/team/remove-member");
    var response = await DataApiService.instance
        .delete("/team/remove-member?userId=$userId&teamId=$teamID")
        .catchError((error) {
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        SnackbarUtil.showSnackbar(message: "Bad Request", type: SnackbarType.error);
      } else {
        _baseController.handleError(error);
      }
    });
    _baseController.hideLoading();
    update();
    if (response == null) return;
    print(response + " responded");
    var result = json.decode(response);

    if (result['success'].toString()=="true") {
      getTeam();

        SnackbarUtil.showSnackbar(message: "Member removed", type: SnackbarType.success);
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
        if(teamList.isNotEmpty){
          isTeamCreated.value=true;
          getSentInvites(teamList[0].id.toString());
        }else{
          isTeamCreated.value=false;
        }


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
          isPlayerInvited.value=false;
          sentInvitesList.clear();
          teamList.clear();
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

  void toggleRoaster(bool value){
    isActiveRoaster.value=value;
  }

}
