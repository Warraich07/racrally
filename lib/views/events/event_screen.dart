import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:racrally/app_widgets/custom_text_field.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:racrally/utils/custom_dialog.dart';
import 'package:racrally/views/events/controller/event_controller.dart';
import 'package:racrally/views/events/widgets/create_event_bottom_sheet.dart';
import 'package:racrally/views/events/widgets/custom_card.dart';
import 'package:racrally/views/team/controller/team_controller.dart';
import 'package:sizer/sizer.dart';
import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_button.dart';
import '../../constants/app_icons.dart';
import '../bottom_nav_bar/controller/bottom_bar_controller.dart';

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
  TeamController teamController=Get.find();
  final GeneralController _generalController = Get.put(GeneralController());

  void onSearchChanged(String value) {
    // Cancel previous timer
    setState(() {
      eventController.eventList.clear();
    });
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    // Start a new timer
    _debounce = Timer(const Duration(milliseconds: 0), () {

      if(value.isEmpty){
        eventController.isSearch.value=false;
        eventController.getEvents(isInitialLoad:true);
      }else{
        // eventController.getEvents(isInitialLoad:true,isSearched:true,searchQuery:value);
        // eventController.searchEvents(value, "asc", true);
        eventController.filterEventsEvents(searchQuery:value);
      }

      print("User stopped typing. Final value: $value");
    });
  }
  final focusNodeSearchHere=FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventController.getEvents(isInitialLoad: true);
    // eventController.resetPagination();
  }
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    _debounce?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton:Obx(
            ()=> Container(
            child: eventController.eventList.isEmpty?Container(): ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: FloatingActionButton(
                backgroundColor: AppTheme.secondaryColor,
                onPressed: () {
                  // if(teamController.teamList.isNotEmpty){
                    focusNodeSearchHere.unfocus();
                    CreateEventSheet.show(context, "name", "location", "dateAndTime", false, "inviteAttendee", "eventId", false,"dateandtimeforupdate",false);
                  // }else{
                  //   CustomDialog.showDeleteDialog(
                  //       buttonColor: AppTheme.secondaryColor,
                  //       borderColor: AppTheme.secondaryColor,
                  //       showIcon: false,
                  //       title: "Create Your Team First",
                  //       description: "You need a team before you can create events and invite members.",
                  //       confirmText: "Create Team",
                  //       onConfirm: (){
                  //         Get.back();
                  //       }
                  //   );
                  // }
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
                          // eventController.eventList.clear();
                          eventController.updateIsFilterAndOrder(true,'asc');
                          eventController.getEvents(isInitialLoad: true,);
                        } else if (value == 'Z-A') {
                          eventController.updateIsFilterAndOrder(true,'desc');
                          eventController.getEvents(isInitialLoad: true,);
                        }
                      }
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
                  Obx(
                        () => eventController.isLoading.value
                        ? SizedBox(
                          height:eventController.isSearch.value? 38.h:38.h,
                          child: const Center(
                                                child: CircularProgressIndicator(color: AppTheme.secondaryColor),
                                              ),
                        )
                        : eventController.eventList.isNotEmpty
                        ? Expanded(
                          child: SmartRefresher(
                            physics: const BouncingScrollPhysics(),
                            controller: eventController.refreshController,
                            enablePullDown: true,
                            enablePullUp: eventController.isMoreDataAvailable.value,
                            onRefresh: () async {
                              await eventController.getEvents(isInitialLoad: true);
                              eventController.refreshController.refreshCompleted();
                              eventController.refreshController.resetNoData();
                            },
                            onLoading: () async {
                             if(eventController.isFilter.value){
                               await eventController.getEvents();
                             }else{
                               await eventController.getEvents();
                             }
                              eventController.isMoreDataAvailable.value
                                  ? eventController.refreshController.loadComplete()
                                  : eventController.refreshController.loadNoData();
                            },
                              child: ListView.builder(
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
                                onTap: () async {
                                  await eventController.getEventDetails(event.id.toString());

                                  // Delay navigation slightly to avoid async conflict (optional)
                                  Future.delayed(Duration(milliseconds: 100), () {
                                    if (mounted) {
                                      Get.toNamed(
                                        AppRoutes.eventDetail,
                                        arguments: {
                                          'eventName': event.name.capitalizeFirst!,
                                          'date': eventController.formatDate(event.date.toString()).capitalizeFirst!,
                                          'location': event.location.capitalizeFirst,
                                          'eventId': event.id,
                                          'inviteAttendee': event.inviteAttandee,
                                          'dateANdTimeForUpdateEvent': event.date.toString()
                                        },
                                      );
                                    }
                                  });
                                },

                                child: CustomCard(
                                onEditTap: (){
                                  CreateEventSheet.show(context, event.name.capitalizeFirst!, event.location.capitalizeFirst!, eventController.formatDate(event.date.toString()).capitalizeFirst!, false, event.inviteAttandee, event.id.toString(),true,event.date.toString(),false);
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
                                                  ),
                          ),
                        )
                        :eventController.isSearch.value?SizedBox(
                            height: 35.h,
                            child: Center(child: Text("No Events Found", style: AppTheme.mediumLightHeadingWeight600Style))):
                        SizedBox(
                          height:eventController.isLoading.value?30.h: 60.h,
                              child: Center(
                                                    child: SingleChildScrollView(
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
                                                                                      if(teamController.teamList.isNotEmpty){
                                                                                        CreateEventSheet.show(context, "name", "location", "formattedDate", false, "inviteAttendee", "eventId", false, "dateAndTimeForUpdateEvent",false);
                                                                                      }else{
                                                                                        CustomDialog.showDeleteDialog(
                                                                                            buttonColor: AppTheme.secondaryColor,
                                                                                            borderColor: AppTheme.secondaryColor,
                                                                                            showIcon: false,
                                                                                            title: "Create Your Team First",
                                                                                            description: "You need a team before you can create events and invite members.",
                                                                                            confirmText: "Create Team",
                                                                                            onConfirm: (){
                                                                                              Get.back();
                                                                                              _generalController.onBottomBarTapped(1);
                                                      
                                                                                            }
                                                                                        );
                                                                                      }
                                                      
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
