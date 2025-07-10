import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../app_theme/app_theme.dart';
import '../../../app_widgets/custom_button.dart';
import '../../../app_widgets/custom_text_field.dart';
import '../../../utils/snackbar_utils.dart';
import '../../auth/widgets/custom_dropdown.dart';
import '../controller/event_controller.dart';

class CreateEventSheet {
  static void show(BuildContext context) {
    final EventController controller = Get.find();
    final focusNodePassword = FocusNode();

    // Separate state variables
    String? inviteAttendee;
    String? firstReminder;
    String? lastReminder;
    final TextEditingController dateAndTimeController = TextEditingController();
    final TextEditingController rsvpDeadlineController = TextEditingController();
    bool isSwitched = false;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                        child: Text("Create Event", style: AppTheme.mediumHeadingStyle),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        fieldName: "Event Name",
                        hintText: "Enter event name...",
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        fieldName: "Venue",
                        hintText: "Enter venue address...",
                      ),
                      const SizedBox(height: 18),

                      // Date Picker
                      GestureDetector(
                        onTap: () {
                          pickDate(context, dateAndTimeController);
                        },
                        child: AbsorbPointer(
                          child: CustomTextField(
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
                        fieldName: "Invite Attendee",
                        hintText: "Select",
                        value: inviteAttendee,
                        items: const [
                          DropdownMenuItem(value: "Invite All", child: Text("Invite All")),
                          DropdownMenuItem(value: "Substitute Only", child: Text("Substitute Only")),
                          DropdownMenuItem(value: "Players Only", child: Text("Players Only")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            inviteAttendee = value;
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
                      if (isSwitched)
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                pickDate(context, rsvpDeadlineController);
                              },
                              child: AbsorbPointer(
                                child: CustomTextField(
                                  controller: rsvpDeadlineController,
                                  focusNode: focusNodePassword,
                                  suffixIcon: const Icon(Icons.calendar_today_outlined),
                                  isObscure: false,
                                  fieldName: "RSVP Deadline",
                                  hintText: "Select",
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // First Reminder Dropdown
                                SizedBox(
                                  width: 44.w,
                                  child: CustomDropdownField(
                                    fontSize: 13,
                                    fieldName: "First Reminder",
                                    hintText: "Select",
                                    value: firstReminder,
                                    items: const [
                                      DropdownMenuItem(
                                          value: "24 hours before",
                                          child: Text("24 hours before")),
                                      DropdownMenuItem(
                                          value: "16 hours before",
                                          child: Text("16 hours before")),
                                      DropdownMenuItem(
                                          value: "8 hours before",
                                          child: Text("8 hours before")),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        firstReminder = value;
                                      });
                                    },
                                  ),
                                ),

                                // Last Reminder Dropdown
                                SizedBox(
                                  width: 44.w,
                                  child: CustomDropdownField(
                                    fontSize: 10,
                                    fieldName: "Last Reminder",
                                    hintText: "Select",
                                    value: lastReminder,
                                    items: const [
                                      DropdownMenuItem(
                                          value: "8 hours before",
                                          child: Text("8 hours before")),
                                      DropdownMenuItem(
                                          value: "4 hours before",
                                          child: Text("4 hours before")),
                                      DropdownMenuItem(
                                          value: "2 hours before",
                                          child: Text("2 hours before")),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        lastReminder = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                      const SizedBox(height: 18),
                      CustomButton(
                        onTap: () {
                          Get.back();
                          SnackbarUtil.showSnackbar(
                            message: "Event Created",
                            type: SnackbarType.success,
                          );
                        },
                        Text: "Create Event",
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> pickDate(BuildContext context, TextEditingController controller) async {
    final ThemeData theme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        onSurfaceVariant: AppTheme.secondaryColor,
        onSecondary: AppTheme.darkBackgroundColor,
        primary: AppTheme.secondaryColor,
        onPrimary: AppTheme.primaryColor,
        onSurface: AppTheme.darkBackgroundColor,
        surface: AppTheme.primaryColor,
      ),
    );

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(data: theme, child: child!);
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      controller.text = formattedDate;
      printSelectedDate(pickedDate);
    }
  }

  static void printSelectedDate(DateTime date) {
    final String formatted = DateFormat('EEEE, dd MMMM yyyy').format(date);
    print("Selected date: $formatted");
  }
}
