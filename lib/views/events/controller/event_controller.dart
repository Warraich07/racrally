import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:racrally/models/event_details_model.dart';
import 'package:racrally/models/event_model.dart';

import '../../../api_services/api_exceptions.dart';
import '../../../api_services/data_api.dart';
import '../../../controllers/base_controller.dart';
import '../../../utils/snackbar_utils.dart';

class EventController extends GetxController {

  RxBool isLoading=false.obs;
  // final BaseController _baseController = BaseController.instance;
  // Rxn<TeamModel> teamData=Rxn<TeamModel>();
  RxList<EventModel> eventList=<EventModel>[].obs;
  RxList<EventDetailsModel> eventDetailsList=<EventDetailsModel>[].obs;
  RxList<EventModel> eventListBackup=<EventModel>[].obs;
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  RxBool isSearch=false.obs;
  RxBool isFilter=false.obs;
  RxString order=''.obs;
  final BaseController _baseController = BaseController.instance;

  void updateIsFilterAndOrder(bool value,String orderValue){
    isFilter.value;
    order.value=orderValue;
  }


  Future reSendInvite(String userId,String eventId,String inviteId) async {
    _baseController.showLoading();

    var response = await DataApiService.instance
        .put("/resend-invite/$inviteId",{})
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
      // Get.back();
      getEventDetails(eventId);
      SnackbarUtil.showSnackbar(message: "Invite Re-Sent", type: SnackbarType.success);

      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future removeMemberFromEvent(String userId,String eventId) async {
    _baseController.showLoading();
    print("/team/remove-member");
    print("/event/remove_member?userId=$userId&eventId=$eventId");
    var response = await DataApiService.instance
        .delete("/event/remove_member?userId=$userId&eventId=$eventId")
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
      // getTeam();
      getEventDetails(eventId);

      SnackbarUtil.showSnackbar(message: "Member removed", type: SnackbarType.success);
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future createEvent(String name,String location,String dateAndTime,bool rsvp,String inviteAttendee ) async {
    isLoading.value=true;
    // isMoreDataAvailable.value = true;
    // refreshController.resetNoData();
    final BaseController _baseController = BaseController.instance;
    Map<String, String> body = {
      "name": name,
      "location": location,
      "date": dateAndTime,
      "rsvp": rsvp.toString(),
      "inviteAttandee": inviteAttendee
    };
    var response = await DataApiService.instance
        .post("/event", body)
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
      await getEvents(isInitialLoad: true);
      refreshController.resetNoData();
      Get.back();
      SnackbarUtil.showSnackbar(
        message: "Event Created",
        type: SnackbarType.success,
      );

      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      isLoading.value=false;
      print("error is here");
      String message = result['data']['message'];
      print(message);
      if(message.toString()=='Event not found'){
      }
      // SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future updateEvent(String name,String location,String dateAndTime,bool rsvp,String inviteAttendee ,String eventId,bool isFromEventDetailsScreen) async {
    isLoading.value=true;
    final BaseController _baseController = BaseController.instance;
    Map<String, String> body = {
      "name": name,
      "location": location,
      "date": dateAndTime,
      "rsvp": rsvp.toString(),
      "inviteAttandee": inviteAttendee
    };
    var response = await DataApiService.instance
        .put("/event/$eventId", body)
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
      getEvents(isInitialLoad: true);
      Get.back();
      SnackbarUtil.showSnackbar(
        message: "Event Updated",
        type: SnackbarType.success,
      );
      if(isFromEventDetailsScreen){
        getEventDetails(eventId);
      }
      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      isLoading.value=false;
      print("error is here");
      String message = result['data']['message'];
      print(message);
      if(message.toString()=='Event not found'){
      }
      // SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future deleteEvent(String eventId,bool isFromDetailsScreen) async {
    isLoading.value=true;
    final BaseController _baseController = BaseController.instance;

    var response = await DataApiService.instance
        .delete("/event/$eventId")
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
      if(isFromDetailsScreen){Get.back();}
      eventList.clear();
      getEvents(isInitialLoad: true);

      SnackbarUtil.showSnackbar(
        message: "Event Deleted",
        type: SnackbarType.success,
      );

      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      isLoading.value=false;
      print("error is here");
      String message = result['data']['message'];
      print(message);
      if(message.toString()=='Event not found'){
      }
      // SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }
  RxInt page = 1.obs;
  RxInt size = 2.obs;
  RxInt totalCount = 0.obs;
  RxBool isMoreDataAvailable = true.obs;

  Future<void> getEvents({bool isInitialLoad = false}) async {
    isLoading.value=true;
    if (isInitialLoad) {
      page.value = 1;
      eventList.clear();
      isMoreDataAvailable.value = true;

    }

    if (!isMoreDataAvailable.value) return;
    String endPoint='';
    if(isFilter.value==true){
      endPoint='/event?page=${page.value}&size=2&order=$order';
    }else{
      endPoint='/event?page=${page.value}&size=2';
    }
    try {
      final response = await DataApiService.instance.get(endPoint);
      if (response == null) return;

      final result = json.decode(response);
      isLoading.value=false;
      if (result['success'] != true) return;

      final List<EventModel> newEvents = List<EventModel>.from(
        result['data']['events'].map((x) => EventModel.fromJson(x)),
      );

      eventList.addAll(newEvents);

      final totalCount = int.tryParse(result['data']['count'].toString()) ?? 0;
      if (eventList.length >= totalCount) {
        isMoreDataAvailable.value = false;
      } else {
        page.value += 1;
      }

      update();
    } catch (e) {
      BaseController.instance.handleError(e);
    }
  }



  Future filterEventsEvents({bool isInitialLoad = true,String searchQuery=''}) async {
    isSearch.value=true;
    if (isInitialLoad) {
      page.value = 1;
      eventList.clear();
      // totalCount.value=0;
      eventList.clear();
      isMoreDataAvailable.value = true;
    }

    if (!isMoreDataAvailable.value) return;

    isLoading.value = true;
    // isSearch.value = false;

    final BaseController _baseController = BaseController.instance;
    String endPoint='';
      endPoint="/event?page=${page.value}&size=${size.value}&name=$searchQuery";

    var response = await DataApiService.instance
        .get(endPoint)
        .catchError((error) {
      isLoading.value = false;
      if (error is BadRequestException) {
        SnackbarUtil.showSnackbar(message: "Bad Request", type: SnackbarType.error);
      } else {
        _baseController.handleError(error);
      }
    });

    update();
    _baseController.hideLoading();
    if (response == null) return;

    var result = json.decode(response);
    isLoading.value = false;

    if (result['success'].toString() == "true") {
      List<EventModel> newEvents = List<EventModel>.from(
        result['data']['events'].map((x) => EventModel.fromJson(x)),
      );

      totalCount.value = int.tryParse(result['data']['count'].toString()) ?? 0;
      eventList.addAll(newEvents);
      if (eventList.length >= totalCount.value) {
        isMoreDataAvailable.value = false;
      } else {
        page.value += 1;
      }
    } else if (result['status'].toString() == "failed" && result['error'].toString() == "true") {
      String message = result['data']['message'];
      if (message == 'Event not found') {
        isMoreDataAvailable.value = false;
      }
      // SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }


  RxInt totalAcceptedInvites=0.obs;
  RxInt totalRejectedInvites=0.obs;
  RxInt totalNoResponseInvites=0.obs;

  Future getEventDetails(String eventId) async {
    totalAcceptedInvites.value=0;
    totalRejectedInvites.value=0;
    totalNoResponseInvites.value=0;
    isLoading.value=true;
    final BaseController _baseController = BaseController.instance;
    var response = await DataApiService.instance
        .get("/event/$eventId")
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
      eventDetailsList.value = List<EventDetailsModel>.from(result['data'].map((x) => EventDetailsModel.fromJson(x)));
      if (eventDetailsList.isNotEmpty && eventDetailsList[0].invites != null) {
        for (var invite in eventDetailsList[0].invites) {
          _countStatus(invite.status);
        }
      }
      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      isLoading.value=false;
      print("error is here");
      String message = result['data']['message'];
      print(message);
      if(message.toString()=='Event not found'){
      }
      // SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  void _countStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'accepted':
        totalAcceptedInvites.value++;
        break;
      case 'pending':
        totalNoResponseInvites.value++;
        break;
      default:
        totalRejectedInvites.value++;
    }
  }


  String formatDate(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString).toLocal(); // Convert to local time
    return DateFormat('EEEE, MMMM d – h:mm a').format(dateTime);
  }

  void resetPagination() {
    refreshController.resetNoData();
  }
}
