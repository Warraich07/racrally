import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_widgets/custom_button.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import 'package:racrally/views/events/widgets/custom_card_attendees.dart';
import 'package:racrally/views/events/widgets/rsvp_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import '../../app_theme/app_theme.dart';
import '../../constants/app_icons.dart';

class EventDetailsScreen extends StatefulWidget {
   EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;
    return Scaffold(
      bottomSheet: Container(
            color: AppTheme.primaryExtraLightColor,
          child: CustomButton(
            onTap: (){
              RSVPSheet.show(context);
            },
              Text: "Enable RSVP").paddingSymmetric(horizontal: 16,vertical: Platform.isIOS?30:0),

      ),
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
        height: 20.h,
        decoration: BoxDecoration(
          color: AppTheme.primaryDarkColor,
          borderRadius: const BorderRadius.only(
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
                         icon: Icon(Icons.more_vert),
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
                            // onEditTap?.call();
                          } else if (value == 'delete') {
                            // onDeleteTap?.call();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Center(child: Text(data['eventName'],style: AppTheme.mediumHeadingFont600Style,)),
                SizedBox().setHeight(10)
              ],
            ).paddingOnly(top: 40,left: 16),
          ),
          Column(
            children: [
             Container(
               padding: EdgeInsets.all(16),
               decoration: BoxDecoration(
                   color:AppTheme.primaryLittleDarkColor.withOpacity(.7),
                   borderRadius: BorderRadius.circular(12)),

               child: Column(
                 children: [
                   Row(
                     children: [
                       Image.asset(AppIcons.calendar,height: 20,width: 20,),
                       SizedBox().setWidth(5),
                       Text(data['date'],style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),),

                     ],
                   ),
                   Divider(
                     color: AppTheme.textfieldBorderColor.withOpacity(0.3),
                   ),
                   Row(
                     children: [
                       Image.asset(AppIcons.location,height: 20,width: 20,),
                       SizedBox().setWidth(5),
                       Text(data['location'],style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),),

                     ],
                   )
                 ],
               ),
             ),
              SizedBox().setHeight(15),
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
              SizedBox().setHeight(10),
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
    );
  }
}
