import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import 'package:racrally/views/events/controller/event_controller.dart';
import 'package:racrally/views/events/widgets/create_event_bottom_sheet.dart';
import 'package:racrally/views/events/widgets/custom_card_attendees.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    // final Map<String, dynamic> data = Get.arguments;
    // eventController.getEventDetails(data['eventId'].toString());
  }
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
        body:eventController.isLoading.value?
        SizedBox(
          height: 100.h,
          child: Center(
            child: CircularProgressIndicator(
              color: AppTheme.secondaryColor,
            ),
          ),
        ):
        Column(
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
                                CreateEventSheet.show(context,data['eventName'], data['location'], data['date'], false,  data['inviteAttendee'], data['eventId'].toString(),true,data['dateANdTimeForUpdateEvent'],true);
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
                    Center(child: Text(eventController.eventDetailsList[0].name,style: AppTheme.mediumHeadingFont600Style,)),
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
                           Text(eventController.formatDate(eventController.eventDetailsList[0].date.toString()),style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),),

                         ],
                       ),
                       Divider(
                         color: AppTheme.textfieldBorderColor.withOpacity(0.3),
                       ),
                       Row(
                         children: [
                           Image.asset(AppIcons.location,height: 20,width: 20,),
                           const SizedBox().setWidth(5),
                           Text(eventController.eventDetailsList[0].location.toString(),style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),),

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
                            children: [ Image.asset(AppIcons.accepted,height: 18,width: 18,),const SizedBox().setWidth(3),Text(eventController.totalAcceptedInvites.value.toString(),style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
                          ),
                          const SizedBox().setWidth(5),
                          Row(
                            children: [ Image.asset(AppIcons.cancelled,height: 18,width: 18,),const SizedBox().setWidth(3),Text(eventController.totalRejectedInvites.value.toString(),style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
                          ),
                          const SizedBox().setWidth(5),
                          Row(
                            children: [ Image.asset(AppIcons.pending,height: 18,width: 18,),const SizedBox().setWidth(3),Text(eventController.totalNoResponseInvites.value.toString(),style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox().setHeight(10),
                  SizedBox(
                    height: 43.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 43.h,
                          child:eventController.eventDetailsList[0].invites.isNotEmpty?
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: eventController.eventDetailsList[0].invites.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,index){
                                  var invites=eventController.eventDetailsList[index].invites[index];

                                return CustomCardAttendees(
                                    isAlreadyJoined: invites.status=='accepted'?true:false,
                                    isTeamScreen:true,
                                  onTapSend: (){
                                    eventController.reSendInvite(eventController.eventDetailsList[index].invites[index].user.id.toString(), eventController.eventDetailsList[index].invites[index].eventId.toString(),eventController.eventDetailsList[index].invites[index].id.toString());
                                    print("re send");
                                  },
                                    onDeleteTap: (){
                                      eventController.removeMemberFromEvent(eventController.eventDetailsList[index].invites[index].user.id.toString(), eventController.eventDetailsList[index].invites[index].eventId.toString());
                                    print("delete");
                                    },
                                    name: eventController.eventDetailsList[index].invites[index].user.firstName.toString()+" "+eventController.eventDetailsList[index].invites[index].user.lastName,
                                    details: eventController.eventDetailsList[index].invites[index].user.email,
                                    isAttending:eventController.eventDetailsList[index].invites[index].status=='pending'?null:
                                    eventController.eventDetailsList[index].invites[index].status=='accepted'?true:false);
                              }): Center(
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



                ],
              ).paddingSymmetric(horizontal: 16,vertical: 16)
            ],
          ),

      ),
    );
  }
}
