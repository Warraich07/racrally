import 'dart:async';

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
    _debounce = Timer(const Duration(milliseconds: 700), () {

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
    setState(() {
      eventController.eventList.clear();
    });
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
        floatingActionButton: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FloatingActionButton(
            backgroundColor: AppTheme.secondaryColor,
            onPressed: () {
              focusNodeSearchHere.unfocus();
              CreateEventSheet.show(context);
            },
            child: Icon(Icons.add,color: AppTheme.primaryColor,),
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
            ),
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
                      onTap: () => Get.toNamed(AppRoutes.eventDetail),
                      child: CustomCard(
                        isUpComing: true,
                        title: event.name.capitalizeFirst!,
                        dateTime: eventController.formatDate(event.date.toString()).capitalizeFirst!,
                        location: event.location.capitalizeFirst!,
                        onDeleteTap: () {
                          CustomDialog.showDeleteDialog(iconPath: AppIcons.delete);
                        },
                      ),
                    );
                  },
                )
                    : Center(
                  child: Text("No Events Found.", style: AppTheme.mediumLightHeadingWeight600Style),
                ),
              ),
            )



          ],
        ).paddingOnly(left: 16,right: 16,top: 40),
      ),
    );
  }
}
