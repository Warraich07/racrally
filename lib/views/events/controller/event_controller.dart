import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
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
  RxString detailEventName=''.obs;
  RxString detailEventDate=''.obs;
  RxString detailEventLocation=''.obs;
  RxBool isSearch=false.obs;
  final BaseController _baseController = BaseController.instance;


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
      getEvents();
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
      getEvents();
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
      getEvents();

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
  RxString currentOrder = ''.obs;
  RxBool isFiltered = false.obs;

  Future getEvents({bool isInitialLoad = false, bool? isFilter, String? order}) async {
    if (isInitialLoad) {
      page.value = 1;
      totalCount.value = 0;
      eventList.clear();
       size.value = 2;
      isMoreDataAvailable.value = true;

      // Store current filter for future pagination
      if (isFilter != null) isFiltered.value = isFilter;
      if (order != null) currentOrder.value = order;
    }

    if (!isMoreDataAvailable.value) return;

    isLoading.value = true;
    final BaseController _baseController = BaseController.instance;

    String endPoint = isFiltered.value
        ? "/event?page=${page.value}&size=${size.value}&order=${currentOrder.value}"
        : "/event?page=${page.value}&size=${size.value}";

    var response = await DataApiService.instance.get(endPoint).catchError((error) {
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
    }
  }


  Future filterEventsEvents({bool isInitialLoad = true,bool isSearched=false,String order='asc',String searchQuery='',bool isFilter=false}) async {
    isSearch.value=true;
    if (isInitialLoad) {
      page.value = 1;
      eventList.clear();
      // totalCount.value=0;
      isMoreDataAvailable.value = true;
    }

    if (!isMoreDataAvailable.value) return;

    isLoading.value = true;
    isSearch.value = false;

    final BaseController _baseController = BaseController.instance;
    String endPoint='';
    if(isSearched){
      endPoint="/event?page=${page.value}&size=${size.value}&name=$searchQuery";
    }else{
      endPoint="/event?page=${page.value}&size=${size.value}&order=$order";
    }
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


  Future getEventDetails(String eventId) async {
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


  String formatDate(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString).toLocal(); // Convert to local time
    return DateFormat('EEEE, MMMM d – h:mm a').format(dateTime);
  }

}
