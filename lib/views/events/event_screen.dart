import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_widgets/custom_text_field.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:racrally/utils/custom_dialog.dart';
import 'package:racrally/views/events/controller/event_controller.dart';
import 'package:racrally/views/events/widgets/create_event_bottom_sheet.dart';
import 'package:racrally/views/events/widgets/custom_card.dart';
import 'package:sizer/sizer.dart';


import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_button.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_images.dart';
import '../team/widgets/create_team_sheet.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool showPassword=true;
  String? selectedFirstReminder;
  FocusNode focusNodePassword=FocusNode();
  final TextEditingController dateController = TextEditingController();
  Timer? _debounce;
  EventController eventController=Get.find();

  void onSearchChanged(String value) {
    // Cancel previous timer
    setState(() {
      eventController.eventList.clear();
    });
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    // Start a new timer
    _debounce = Timer(const Duration(milliseconds: 0), () {

      if(value.isEmpty){
        eventController.getEvents();
      }else{
        eventController.searchEvents(value);
      }

      print("User stopped typing. Final value: $value");
    });
  }
  final focusNodeSearchHere=FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
    eventController.getEvents();
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Clean up
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        floatingActionButton:Obx(
            ()=> Container(
            child: eventController.eventList.isEmpty?Container(): ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: FloatingActionButton(
                backgroundColor: AppTheme.secondaryColor,
                onPressed: () {
                  focusNodeSearchHere.unfocus();
                  CreateEventSheet.show(context, "name", "location", "dateAndTime", false, "inviteAttendee", "eventId", false,"dateandtimeforupdate");
                },
                child: Icon(Icons.add,color: AppTheme.primaryColor,),
              ),
            ),
          ),
        ),

        backgroundColor: AppTheme.primaryColor,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Event Management",style: AppTheme.mediumHeadingStyle,),
                Image.asset(AppIcons.event,height: 24,width: 24,)
              ],
            ).paddingOnly(top: Platform.isIOS?30:0),
            SizedBox().setHeight(10),
            CustomTextField(
              focusNode: focusNodeSearchHere,
              hintText: "Search here",
              prefixIcon: AppIcons.search,
              prefixIconColor: AppTheme.lightGreyColor,
              onChanged: onSearchChanged,
            ),
            SizedBox().setHeight(15),
            Expanded(
              child: Obx(
                    () => eventController.isLoading.value
                    ? Center(
                  child: CircularProgressIndicator(color: AppTheme.secondaryColor),
                )
                    : eventController.eventList.isNotEmpty
                    ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: eventController.eventList.length,
                  itemBuilder: (context, index) {
                    final event = eventController.eventList[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.eventDetail,arguments: {
                        'eventName': event.name.capitalizeFirst!,
                        'date': eventController.formatDate(event.date.toString()).capitalizeFirst!,
                        'location': event.location.capitalizeFirst,
                      }),
                      child: CustomCard(
                        onEditTap: (){
                          CreateEventSheet.show(context, event.name.capitalizeFirst!, event.location.capitalizeFirst!, eventController.formatDate(event.date.toString()).capitalizeFirst!, false, event.inviteAttandee, event.id.toString(),true,event.date.toString());
                          print("object");
                        },
                        onDeleteTap:(){
                          CustomDialog.showDeleteDialog(
                              onConfirm: (){
                                eventController.deleteEvent(event.id.toString());
                              },
                              iconPath: AppIcons.delete);
                        },
                        isUpComing: true,
                        title: event.name.capitalizeFirst!,
                        dateTime: eventController.formatDate(event.date.toString()).capitalizeFirst!,
                        location: event.location.capitalizeFirst!,

                      ),
                    );
                  },
                )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppIcons.event_icon,width: 35.w,),
                      Text("No Events Yet!",style: AppTheme.mediumLightHeadingWeight600Style,),
                      Center(child: Text(
                        "Start creating events and invite members.",
                        textAlign: TextAlign.center,
                        style: AppTheme.bodyExtraSmallWeight400Style,)),
                      SizedBox().setHeight(10),
                      CustomButton(
                        height: 40,
                        width: 42.w,
                        iconPath: AppIcons.addIcon,
                        onTap: (){
                          CreateEventSheet.show(context, "name", "location", "formattedDate", false, "inviteAttendee", "eventId", false, "dateAndTimeForUpdateEvent");
                        },
                        Text: "Create Event",
                        borderColor: AppTheme.secondaryColor,
                        buttonColor: AppTheme.secondaryColor,
                        textColor: AppTheme.primaryColor,
                        isAuth: true,
                        isGoogle: false,
                      ),
                      SizedBox().setHeight(20),
                    ],
                  ),
                ),
              ),
            )



          ],
        ).paddingOnly(left: 16,right: 16,top: 40),
      ),
    );
  }
}
