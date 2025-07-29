import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import 'package:racrally/views/events/controller/event_controller.dart';
import 'package:racrally/views/events/widgets/create_event_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import '../../app_theme/app_theme.dart';
import '../../constants/app_icons.dart';
import '../../utils/custom_dialog.dart';

class EventDetailsScreen extends StatefulWidget {
   EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  EventController eventController=Get.find();
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;

    return Obx(
      ()=> Scaffold(
        // bottomSheet: Container(
        //       color: AppTheme.primaryExtraLightColor,
        //     child: CustomButton(
        //       onTap: (){
        //         RSVPSheet.show(context);
        //       },
        //         Text: "Enable RSVP").paddingSymmetric(horizontal: 16,vertical: Platform.isIOS?30:20),
        //
        // ),
        backgroundColor: AppTheme.primaryColor,
        body:  Column(
            children: [
              Container(
                width: double.infinity,
            height: 21.h,
            decoration: const BoxDecoration(
              color: AppTheme.primaryDarkColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     SizedBox(height: Platform.isIOS?30:0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Image.asset(AppIcons.arrow_back_sharp,width: 20,)),
                        Theme(
                          data: Theme.of(context).copyWith(
                            popupMenuTheme: PopupMenuThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: PopupMenuButton<String>(
                             icon: const Icon(Icons.more_vert),
                            color: AppTheme.primaryColor,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Image.asset(AppIcons.edit, height: 20, width: 20),
                                    const SizedBox(width: 10),
                                    Text('Edit', style: AppTheme.bodyMediumGreyStyle),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Image.asset(AppIcons.delete, height: 20, width: 20),
                                    const SizedBox(width: 10),
                                    Text('Delete', style: AppTheme.bodyMediumGreyStyle),
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (value) {
                              if (value == 'edit') {
                                CreateEventSheet.show(context,data['eventName'], data['location'], data['date'], false,  data['inviteAttendee'], data['eventId'].toString(),true,data['dateANdTimeForUpdateEvent']);
                                // onEditTap?.call();
                              } else if (value == 'delete') {
                                CustomDialog.showDeleteDialog(
                                    onConfirm: (){

                                      eventController.deleteEvent(data['eventId'].toString(),true);
                                    },
                                    iconPath: AppIcons.delete);
                                // onDeleteTap?.call();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Center(child: Text(eventController.detailEventName.value,style: AppTheme.mediumHeadingFont600Style,)),
                    const SizedBox().setHeight(10)
                  ],
                ).paddingOnly(top: 40,left: 16),
              ),
              Column(
                children: [
                 Container(
                   padding: const EdgeInsets.all(16),
                   decoration: BoxDecoration(
                       color:AppTheme.primaryLittleDarkColor.withOpacity(.7),
                       borderRadius: BorderRadius.circular(12)),

                   child: Column(
                     children: [
                       Row(
                         children: [
                           Image.asset(AppIcons.calendar,height: 20,width: 20,),
                           const SizedBox().setWidth(5),
                           Text(eventController.detailEventDate.value,style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),),

                         ],
                       ),
                       Divider(
                         color: AppTheme.textfieldBorderColor.withOpacity(0.3),
                       ),
                       Row(
                         children: [
                           Image.asset(AppIcons.location,height: 20,width: 20,),
                           const SizedBox().setWidth(5),
                           Text(eventController.detailEventLocation.value,style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),),

                         ],
                       )
                     ],
                   ),
                 ),
                  const SizedBox().setHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Event Attendees",style: AppTheme.mediumHeadingStyle,),
                      Row(
                        children: [
                          Row(
                            children: [ Image.asset(AppIcons.accepted,height: 18,width: 18,),const SizedBox().setWidth(3),Text("12",style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
                          ),
                          const SizedBox().setWidth(5),
                          Row(
                            children: [ Image.asset(AppIcons.cancelled,height: 18,width: 18,),const SizedBox().setWidth(3),Text("05",style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
                          ),
                          const SizedBox().setWidth(5),
                          Row(
                            children: [ Image.asset(AppIcons.pending,height: 18,width: 18,),const SizedBox().setWidth(3),Text("10",style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox().setHeight(10),
                  SizedBox(
                    height: 43.h,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 43.h,
                            child: Center(
                              child: Text("No Attendees Yet",style: AppTheme.mediumLightHeadingWeight600Style),
                            ),
                          )
                          // CustomCardAttendees(name: 'Noraiz Shahid', details: 'noraizshahid@gmail.com',isAttending:null),
                          // CustomCardAttendees(name: 'Talha', details: 'talha12@gmail.com',isAttending:true),
                          // CustomCardAttendees(name: 'Umer', details: 'umer12@gmail.com',isAttending:false),
                          // CustomCardAttendees(name: 'Umer', details: 'umer12@gmail.com',isAttending:false),
                        ],
                      ),
                    ),
                  ),



                ],
              ).paddingSymmetric(horizontal: 16,vertical: 16)
            ],
          ),

      ),
    );
  }
}
