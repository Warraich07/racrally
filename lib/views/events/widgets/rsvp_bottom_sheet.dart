import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../app_theme/app_theme.dart';
import '../../../app_widgets/custom_button.dart';
import '../../../app_widgets/custom_text_field.dart';
import '../../../constants/custom_validators.dart';
import '../../auth/widgets/custom_dropdown.dart';

class RSVPSheet {
  static void show(BuildContext context) {
    final TextEditingController dateController = TextEditingController();
    String? selectedFirstReminder;
    String? selectedLastReminder;
    final FocusNode focusNodePassword = FocusNode();

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
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
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
                      Text("Add your widgets inside here.",
                          style: AppTheme.mediumHeadingStyle),
                      const SizedBox(height: 20),

                      /// Date Picker
                      GestureDetector(
                        onTap: () async {
                          pickDate(context,dateController);
                        },
                        child: AbsorbPointer(
                          child: CustomTextField(
                            controller: dateController,
                            focusNode: focusNodePassword,
                            suffixIcon: const Icon(Icons.calendar_today_outlined),
                            isObscure: false,
                            fieldName: "RSVP Deadline",
                            hintText: "Select",
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      /// First Reminder Dropdown
                      CustomDropdownField(
                        validator: (value) =>
                            CustomValidator.selectGenderRange(value),
                        fieldName: "First Reminder",
                        hintText: "Select",
                        value: selectedFirstReminder,
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
                            selectedFirstReminder = value;
                          });
                        },
                      ),
                      const SizedBox(height: 18),

                      /// Last Reminder Dropdown
                      CustomDropdownField(
                        validator: (value) =>
                            CustomValidator.selectGenderRange(value),
                        fieldName: "Last Reminder",
                        hintText: "Select",
                        value: selectedLastReminder,
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
                            selectedLastReminder = value;
                          });
                        },
                      ),
                      const SizedBox(height: 18),

                      /// Submit Button
                      CustomButton(
                          onTap: (){
                            Get.back();
                          },
                          Text: "Send RSVP"),
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



