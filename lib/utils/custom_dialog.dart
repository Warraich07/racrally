import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:racrally/app_widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../app_theme/app_theme.dart';
import '../views/auth/widgets/custom_dropdown.dart';



class CustomDialog {

  static Future<dynamic> showDeleteDialog({
    String title = 'Delete Event',
    String subtitle = 'Delete Event',
    String subTitleHeading = 'Team Name: ',
    String description = 'This will remove the event from the system.',
    String confirmText = 'Yes, Delete it',
    VoidCallback? onConfirm,
    String? iconPath,
    bool? showIcon,
    bool? showSubtitle,
    Color? buttonColor,
    Color? borderColor
  }) {
    return Get.dialog(

      Dialog(
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Top Row: Icon, Title, Close Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showIcon==false?Container(): SizedBox(
                    child: iconPath != null
                        ? Image.asset(iconPath, height: 24, width: 24,color: AppTheme.red,)
                        : const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTheme.mediumHeadingStyle,
                        ),
                        const SizedBox(height: 4),

                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, size: 20),
                  )
                ],
              ),
              showSubtitle==true?RichText(text: TextSpan(
                children:[
                  TextSpan(
                    text: subTitleHeading,
                    style: AppTheme.bodySmallGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),
                  ),
                  TextSpan(
                      text: subtitle.capitalizeFirst,
                    style: AppTheme.bodySmallGreyStyle.copyWith(color: AppTheme.secondaryColor),
                  ),
                ]
              )).paddingOnly(left: 5):SizedBox(),
              Text(
                description,
                style: AppTheme.bodySmallGreyStyle,
              ).paddingOnly(left: 5),
              const SizedBox(height: 20),

              /// Confirm Button
              CustomButton(
                borderColor:buttonColor?? AppTheme.red,
                buttonColor:borderColor?? AppTheme.red,
                Text: confirmText,
                onTap: (){
                Get.back();
              if (onConfirm != null) onConfirm();
              },)
            ],
          ),
        ),
      ),
    );
  }

  static Future<dynamic> showReminderDialog({
    String title = 'Send RSVP Reminder',
    String description = 'This will send a push notification and in-app message to Noraiz Shahid asking them to RSVP for the next game.',
    String confirmText = 'Send Reminder',
    VoidCallback? onConfirm,
    String? iconPath,
    String? inviteAttendee
  }) {
    return Get.dialog(

      Dialog(
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Top Row: Icon, Title, Close Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  iconPath != null
                      ? Image.asset(iconPath, height: 24, width: 24,color: AppTheme.secondaryColor,)
                      : const Icon(Icons.alarm, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTheme.mediumHeadingStyle,
                        ),
                        const SizedBox(height: 4),

                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, size: 20),
                  )
                ],
              ),
              Text(
                description,
                style: AppTheme.bodySmallGreyStyle,
              ),
              const SizedBox(height: 20),
            StatefulBuilder(
              builder: (context, setState) {
                final MultiSelectController<String> inviteController = MultiSelectController<String>();

                return MultiDropdown<String>(
                  controller: inviteController,
                  items: [
                    DropdownItem(label: 'vs Viper Saturday, June 22 – 5:00 PM', value: 'vs Viper Saturday, June 22 – 5:00 PM'),
                    DropdownItem(label: 'vs Sultan Saturday, June 22 – 5:00 PM', value: 'vs Sultan Saturday, June 22 – 5:00 PM'),
                  ],
                  searchEnabled: false,
                  chipDecoration: const ChipDecoration(
                    wrap: true,
                    spacing: 8,
                    runSpacing: 4,
                    backgroundColor: Colors.grey,
                  ),
                  selectedItemBuilder: (item) {
                    // Extract only "vs TeamName"
                    final parts = item.label.split(" ");
                    final shortLabel = parts.length >= 2 ? "${parts[0]} ${parts[1]}" : item.label;

                    return Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color:AppTheme.secondaryColor),
                      ),
                      backgroundColor: AppTheme.secondaryColor,
                      label: Text(
                        shortLabel,
                        style: AppTheme.bodyExtraSmallFontTenStyle.copyWith(
                          color: AppTheme.primaryColor
                        ),
                      ),
                      deleteIcon: const Icon(Icons.close, size: 16, color: Colors.white),
                      onDeleted: () {
                        inviteController.unselectWhere((e) => e.label == item.label);
                      },
                    );
                  },
                  fieldDecoration: FieldDecoration(
                    labelText: "Upcoming Games",
                    hintText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:  BorderSide(color: AppTheme.textfieldBorderColor.withOpacity(.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:  BorderSide(color: AppTheme.textfieldBorderColor.withOpacity(.3)),
                    ),
                  ),

                );
              },
            ),








            const SizedBox(height: 20),

              /// Confirm Button
              CustomButton(
                borderColor: AppTheme.secondaryColor,
                buttonColor: AppTheme.secondaryColor,
                Text: "Send Reminder",
                onTap: (){
                  Get.back();
                  if (onConfirm != null) onConfirm();},)
            ],
          ),
        ),
      ),
    );
  }

  static Future<dynamic> showErrorDialog({
    String title = 'Error',
    String? description = 'Something went wrong',
    int? maxLine,
    dynamic Function()? onTap,
    String? buttonText,
    bool showTitle=false,
    String? iconPath
  }) {
    return Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20.0)), //this right here
          child: Container(
            height:380,
            width: 100.w,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppTheme.primaryColor,
              border: Border.all(color: AppTheme.whiteColor,width: 2.7),

            ),
            child: Column(
              children: [

               SizedBox(height: 50,),
                // Image.asset(
                //   iconPath?? AppIcons.errorIcon,
                //   scale: 4.6,
                // ),
                SizedBox(height: 10,),
                // const Spacer(),
                showTitle? Text(
                  title,
                  style:  TextStyle(fontSize: 22,height: 1.2, fontFamily: "bold",color: AppTheme.whiteColor),
                  textAlign: TextAlign.center,
                ):Container(),
                showTitle? SizedBox(height: 10):Container(),
                SizedBox(height: 10,),
                Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 12,
                    fontFamily: "Bold",
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),

                const Spacer(),
                ZoomTapAnimation(
                    onTap: onTap??(){
                      Get.back();
                    },
                    enableLongTapRepeatEvent: false,
                    longTapRepeatDuration: const Duration(milliseconds: 100),
                    begin: 1.0,
                    end: 0.93,
                    beginDuration: const Duration(milliseconds: 20),
                    endDuration: const Duration(milliseconds: 120),
                    beginCurve: Curves.decelerate,
                    endCurve: Curves.fastOutSlowIn,
                    child: Container(
                      height: 55,
                      width: 90.w,
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                      ),
                      child: Center(
                          child: Text(buttonText??"Back",
                              style:  TextStyle(
                                  color: AppTheme.primaryColor,


                                  fontSize: 16,
                                  fontFamily: "Bold"))),
                    )),
                SizedBox(height: 15),
              ],
            ),

          ),
        )
    );
  }




  static void showLoading([String? message]) {
    Get.dialog(
      Center(
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: AppTheme.secondaryColor),
                const SizedBox(height: 8),
                Text(message ?? 'Loading...'),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}

