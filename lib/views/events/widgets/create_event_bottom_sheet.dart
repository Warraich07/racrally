import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../app_theme/app_theme.dart';
import '../../../app_widgets/custom_button.dart';
import '../../../app_widgets/custom_text_field.dart';
import '../../../constants/custom_validators.dart';
import '../../auth/widgets/custom_dropdown.dart';
import '../controller/event_controller.dart';

class CreateEventSheet {
  static void show(BuildContext context,String? name,String? location,String? formattedDate,bool? rsvp,String? inviteAttendee ,String? eventId,bool? isUpdate,String? dateAndTimeForUpdateEvent,bool isFromEventDetailsScreen) {
    final EventController controller = Get.find();
    final focusNodePassword = FocusNode();
    EventController eventController=Get.find();
    // Separate state variables
    String? playerType;
    String? firstReminder;
    String? lastReminder;
    final  dateAndTimeController = TextEditingController();
    final  eventNameController = TextEditingController();
    final  venueController = TextEditingController();
    final  attendeeController = TextEditingController();
    final TextEditingController rsvpDeadlineController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey();
    final focusNodeEvent=FocusNode();
    final focusNodeVenue=FocusNode();
    bool isSwitched = false;
    String dateAndTime='';

    bool isInitialized = false;
    showModalBottomSheet(

      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {

        return StatefulBuilder(
          builder: (context, setState) {
            if (isUpdate == true && !isInitialized) {
              eventNameController.text = name ?? '';
              venueController.text = location ?? '';
              dateAndTimeController.text = formattedDate ?? '';
              playerType = inviteAttendee ?? '';
              isSwitched = rsvp ?? false;
              dateAndTime = dateAndTimeForUpdateEvent ?? '';
              isInitialized = true;
            }
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24),
                    ),
                    color: AppTheme.primaryColor,
                  ),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              width: 76,
                              height: 5,
                              color: AppTheme.dividerColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Text(isUpdate==true?"Update Event":"Create Event", style: AppTheme.mediumHeadingStyle),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          focusNode: focusNodeEvent,
                          controller: eventNameController,
                          validator: (value) => CustomValidator.event(value),
                          fieldName: "Event Name",
                          hintText: "Enter event name...",
                        ),
                        const SizedBox(height: 18),
                        CustomTextField(
                          focusNode: focusNodeVenue,
                          validator: (value) => CustomValidator.venue(value),
                          controller: venueController,
                          fieldName: "Venue",
                          hintText: "Enter venue address...",
                        ),
                        const SizedBox(height: 18),

                        // Date Picker
                        GestureDetector(
                          onTap: () {
                            focusNodeEvent.unfocus();
                            focusNodeVenue.unfocus();
                            pickDate(context, dateAndTimeController, (selectedDate) {
                              dateAndTime = selectedDate;
                            });

                          },
                          child: AbsorbPointer(
                            child: CustomTextField(
                              validator: (value) => CustomValidator.dateAndTime(value),
                              controller: dateAndTimeController,
                              focusNode: focusNodePassword,
                              suffixIcon: const Icon(Icons.calendar_today_outlined, size: 24),
                              isObscure: false,
                              fieldName: "Date & Time",
                              hintText: "Select",
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Invite Attendee Dropdown
                        CustomDropdownField(
                          validator: (value) => CustomValidator.attendee(value),
                          // controller: dateAndTimeController,
                          fieldName: "Invite Attendee",
                          hintText: "Select",
                          value: playerType,
                          items: const [
                            DropdownMenuItem(value: "all", child: Text("Invite All")),
                            DropdownMenuItem(value: "reserve_player", child: Text("Substitute Only")),
                            DropdownMenuItem(value: "active_roaster", child: Text("Players Only")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              playerType = value;
                            });
                          },
                        ),
                        const SizedBox(height: 18),

                        // RSVP Switch
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.primaryLittleDarkColor.withOpacity(.7),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enable RSVP", style: AppTheme.bodyMediumFont600Style),
                                  const SizedBox(height: 5),
                                  Text(
                                    "To send reminders and RSVP\nto attendees, make sure you enable it",
                                    style: AppTheme.bodyExtraSmallWeight400Style.copyWith(
                                      color: AppTheme.mediumGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                              Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                },
                                activeColor: AppTheme.primaryColor,
                                activeTrackColor: AppTheme.secondaryColor,
                                inactiveThumbColor: AppTheme.primaryColor,
                                inactiveTrackColor: AppTheme.lightGreyColor,
                              ),
                            ],
                          ).paddingAll(16),
                        ),

                        const SizedBox(height: 18),

                        // RSVP fields
                        // if (isSwitched)
                        //   Column(
                        //     children: [
                        //       GestureDetector(
                        //         onTap: () async {
                        //           pickDate(context, rsvpDeadlineController, (selectedDate) {
                        //             dateAndTime = selectedDate;
                        //           });
                        //
                        //         },
                        //         child: AbsorbPointer(
                        //           child: CustomTextField(
                        //             controller: rsvpDeadlineController,
                        //             focusNode: focusNodePassword,
                        //             suffixIcon: const Icon(Icons.calendar_today_outlined),
                        //             isObscure: false,
                        //             fieldName: "RSVP Deadline",
                        //             hintText: "Select",
                        //           ),
                        //         ),
                        //       ),
                        //       const SizedBox(height: 18),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           // First Reminder Dropdown
                        //           SizedBox(
                        //             width: 44.w,
                        //             child: CustomDropdownField(
                        //               fontSize: 13,
                        //               fieldName: "First Reminder",
                        //               hintText: "Select",
                        //               value: firstReminder,
                        //               items: const [
                        //                 DropdownMenuItem(
                        //                     value: "24 hours before",
                        //                     child: Text("24 hours before")),
                        //                 DropdownMenuItem(
                        //                     value: "16 hours before",
                        //                     child: Text("16 hours before")),
                        //                 DropdownMenuItem(
                        //                     value: "8 hours before",
                        //                     child: Text("8 hours before")),
                        //               ],
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   firstReminder = value;
                        //                 });
                        //               },
                        //             ),
                        //           ),
                        //
                        //           // Last Reminder Dropdown
                        //           SizedBox(
                        //             width: 44.w,
                        //             child: CustomDropdownField(
                        //               fontSize: 10,
                        //               fieldName: "Last Reminder",
                        //               hintText: "Select",
                        //               value: lastReminder,
                        //               items: const [
                        //                 DropdownMenuItem(
                        //                     value: "8 hours before",
                        //                     child: Text("8 hours before")),
                        //                 DropdownMenuItem(
                        //                     value: "4 hours before",
                        //                     child: Text("4 hours before")),
                        //                 DropdownMenuItem(
                        //                     value: "2 hours before",
                        //                     child: Text("2 hours before")),
                        //               ],
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   lastReminder = value;
                        //                 });
                        //               },
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //     ],
                        //   ),

                        const SizedBox(height: 18),
                        CustomButton(
                          onTap: () {
                           if(_formKey.currentState!.validate()){
                            if(isUpdate==true){
                              print(dateAndTimeController.text.toString());
                              print(playerType);
                              eventController.eventList.clear();
                              print("updation");
                              eventController.updateEvent(
                                  eventNameController.text.toString(),
                                  venueController.text.toString(),
                                  dateAndTime,
                                  false,
                                  playerType!,
                                eventId.toString(),
                                isFromEventDetailsScreen
                              );
                            }else{
                              print("creation");
                              print(dateAndTimeController.text.toString());
                              print(playerType);
                              eventController.eventList.clear();
                              eventController.createEvent(
                                  eventNameController.text.toString(),
                                  venueController.text.toString(),
                                  dateAndTime,
                                  false,
                                  playerType!);
                            }

                           }
                          },
                          Text:isUpdate==true?"Update Event":"Create Event",
                        ),
                        SizedBox(height: Platform.isIOS?30:0,)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


  static Future<void> pickDate(
      BuildContext context,
      TextEditingController controller,
      Function(String) onDateSelected,
      ) async {
    final ThemeData theme = ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        onSurfaceVariant: AppTheme.secondaryColor,
        onSecondary: AppTheme.darkBackgroundColor,
        primary: AppTheme.secondaryColor,
        onPrimary: AppTheme.primaryColor,
        onSurface: AppTheme.darkBackgroundColor,
        surface: AppTheme.primaryColor,
      ),
    );

    final DateTime now = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(data: theme, child: child!),
    );

    if (pickedDate != null) {
      // Hide keyboard input mode by setting MediaQuery config
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: Theme(data: theme, child: child!),
          );
        },
      );

      if (pickedTime != null) {
        final selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (selectedDateTime.isAfter(now)) {
          final utcDateTime = selectedDateTime.toUtc();
          final formattedDateForApi =
          utcDateTime.toIso8601String().replaceFirst('.000Z', 'Z');
          final formattedReadableDate =
          DateFormat('EEEE, MMMM d – h:mm a').format(selectedDateTime);

          controller.text = formattedReadableDate;
          onDateSelected(formattedDateForApi);
        } else {
          controller.clear(); // optional
        }
      }
    }
  }





  static void printSelectedDate(DateTime date) {
    final String formatted = DateFormat('EEEE, dd MMMM yyyy').format(date);
    print("Selected date: $formatted");
  }
}
