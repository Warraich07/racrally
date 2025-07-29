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
        eventController.searchEvents(value, "asc", true);
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
                child:  const Icon(Icons.add,color: AppTheme.primaryColor,),
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
                // GestureDetector(
                //     onTap: (){
                //
                //       print("object");
                //     },
                //     child: Image.asset(AppIcons.event,height: 24,width: 24,)),
                Theme(
                  data: Theme.of(context).copyWith(
                    popupMenuTheme: PopupMenuThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: PopupMenuButton<String>(
                    icon: Image.asset(AppIcons.event,height: 24,width: 24,),
                    color: AppTheme.primaryColor,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'A-Z',
                        child: Row(
                          children: [
                            const Icon(Icons.filter_alt_off,color: AppTheme.lightGreyColor,),
                            const SizedBox(width: 10),
                            Text('A-Z', style: AppTheme.bodyMediumGreyStyle),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'Z-A',
                        child: Row(
                          children: [
                            const Icon(Icons.filter_alt_off,color: AppTheme.lightGreyColor,),
                            const SizedBox(width: 10),
                            Text('Z-A', style: AppTheme.bodyMediumGreyStyle),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      focusNodeSearchHere.unfocus();
                      if (value == 'A-Z') {
                        eventController.searchEvents("", "asc", false);
                        print("A-Z");
                      } else if (value == 'Z-A') {
                        print("Z-A");
                        eventController.searchEvents("", "desc", false);
                      }
                    },
                  ),
                ),
              ],
            ).paddingOnly(left: 16,top:Platform.isIOS?70: 40,right: 5),
            Expanded(
              child: Column(
                children: [
              
                  const SizedBox().setHeight(10),
                  CustomTextField(
                    focusNode: focusNodeSearchHere,
                    hintText: "Search here",
                    prefixIcon: AppIcons.search,
                    prefixIconColor: AppTheme.lightGreyColor,
                    onChanged: onSearchChanged,
                  ),
                  const SizedBox().setHeight(15),
                  Expanded(
                    child: Obx(
                          () => eventController.isLoading.value
                          ? const Center(
                        child: CircularProgressIndicator(color: AppTheme.secondaryColor),
                      )
                          : eventController.eventList.isNotEmpty
                          ? ListView.builder(
                        padding: const EdgeInsets.only(top: 0,bottom: 40),
                        itemCount: eventController.eventList.length,
                        itemBuilder: (context, index) {
                          final event = eventController.eventList[index];
                          final DateTime now = DateTime.now();
                          final DateTime today = DateTime(now.year, now.month, now.day);
                          final DateTime eventDateTime = DateTime.parse(event.date.toString());
                          final DateTime eventDateOnly = DateTime(eventDateTime.year, eventDateTime.month, eventDateTime.day);
                          final bool isUpcoming = eventDateOnly.isAfter(today) || eventDateOnly.isAtSameMomentAs(today);
              
                          return GestureDetector(
                            onTap: (){
                                  Get.toNamed(AppRoutes.eventDetail,
                                  arguments: {
                                    'eventName': event.name.capitalizeFirst!,
                                    'date': eventController.formatDate(event.date.toString()).capitalizeFirst!,
                                    'location': event.location.capitalizeFirst,
                                    'eventId':event.id,
                                    'inviteAttendee': event.inviteAttandee,
                                    'dateANdTimeForUpdateEvent':event.date.toString()
                                  });
                                  eventController.detailEventDate.value=eventController.formatDate(event.date.toString()).capitalizeFirst!;
                                  eventController.detailEventName.value= event.name.capitalizeFirst!;
                                  eventController.detailEventLocation.value=event.location.capitalizeFirst!;
                            },
                            child: CustomCard(
                              onEditTap: (){
                                CreateEventSheet.show(context, event.name.capitalizeFirst!, event.location.capitalizeFirst!, eventController.formatDate(event.date.toString()).capitalizeFirst!, false, event.inviteAttandee, event.id.toString(),true,event.date.toString());
                                print("object");
                              },
                              onDeleteTap:(){
                                CustomDialog.showDeleteDialog(
                                    onConfirm: (){
                                      eventController.deleteEvent(event.id.toString(),false);
                                    },
                                    iconPath: AppIcons.delete);
                              },
                              isUpComing: isUpcoming,
                              title: event.name.capitalizeFirst!,
                              dateTime: eventController.formatDate(event.date.toString()).capitalizeFirst!,
                              location: event.location.capitalizeFirst!,
              
                            ),
                          );
                        },
                      )
                          :eventController.isSearch.value?SizedBox(
                              height: 40.h,
                              child: Center(child: Text("No Events Found", style: AppTheme.mediumLightHeadingWeight600Style))): Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppIcons.event_icon,width: 35.w,),
                            Text("No Events Yet!",style: AppTheme.mediumLightHeadingWeight600Style,),
                            Center(child: Text(
                              "Start creating events and invite members.",
                              textAlign: TextAlign.center,
                              style: AppTheme.bodyExtraSmallWeight400Style,)),
                            const SizedBox().setHeight(10),
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
                            const SizedBox().setHeight(20),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ).paddingOnly(left: 16,right: 16),
            ),
          ],
        ),
      ),
    );
  }
}
