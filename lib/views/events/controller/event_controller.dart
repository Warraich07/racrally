import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  Future updateEvent(String name,String location,String dateAndTime,bool rsvp,String inviteAttendee ,String eventId) async {
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

  Future deleteEvent(String eventId) async {
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
      eventList.clear();
      getEvents();
      Get.back();
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


  Future getEvents() async {
    isLoading.value=true;
    final BaseController _baseController = BaseController.instance;



    var response = await DataApiService.instance
        .get("/event")
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
      eventList.value = List<EventModel>.from(result['data'].map((x) => EventModel.fromJson(x)));


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

  Future searchEvents(String searchQuery) async {
    isLoading.value=true;
    final BaseController _baseController = BaseController.instance;

    var response = await DataApiService.instance
        .get("/event/event?name=$searchQuery")
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
      eventList.value = List<EventModel>.from(result['data'].map((x) => EventModel.fromJson(x)));


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
