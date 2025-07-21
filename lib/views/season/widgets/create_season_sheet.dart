import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../app_theme/app_theme.dart';
import '../../../app_widgets/custom_button.dart';
import '../../../app_widgets/custom_text_field.dart';
import '../../../constants/app_icons.dart';
import '../../../constants/app_images.dart';
import '../../../models/text_field_model.dart';
import '../../../utils/snackbar_utils.dart';
import '../../auth/widgets/custom_dropdown.dart';

class CreateSeasonSheet {
  static void show(BuildContext context) {
    // final EventController controller = Get.find();
    final focusNodePassword = FocusNode();
    final TextEditingController dateAndTimeController = TextEditingController();
    XFile? image;
    String imagePath='';
    File? _pickedImage;
    List<VenueField> venueFields = [
      VenueField(label: "Venue"),
      VenueField(label: "Venue"),
    ];

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
                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 1,
                                  color: AppTheme.textfieldBorderColor.withOpacity(.3),
                                ),
                              ),
                              child: Center(
                                child: _pickedImage != null
                                    ? ClipOval(
                                  child: Image.file(
                                    _pickedImage!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Image.asset(
                                  AppImages.placeHolder,
                                  height: 27,
                                  width: 30,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              iconColor: AppTheme.darkBackgroundColor,
                              textSize: 12,
                              width: 35.w,
                              height: 40,
                              iconPath: AppIcons.addIcon,
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                image = await picker.pickImage(source: ImageSource.gallery);
                                imagePath=image!.path;

                                if (image != null) {
                                  setState(() {
                                    _pickedImage = File(image!.path);
                                    print(_pickedImage);
                                    print(image?.path);
                                  });
                                } else {
                                  print('No image selected.');
                                }
                              },
                              Text: "Upload Logo",
                              borderColor: AppTheme.textfieldBorderColor.withOpacity(.3),
                              buttonColor: AppTheme.primaryColor,
                              textColor: AppTheme.darkBackgroundColor,
                              isAuth: true,
                              isGoogle: false,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: Text("Create Event", style: AppTheme.mediumHeadingStyle),
                      // ),
                      // const SizedBox(height: 20),
                      CustomTextField(
                        fieldName: "Season Name",
                        hintText: "Enter season name...",
                      ),
                      const SizedBox(height: 18),
                      ListView.builder(
                        itemCount: venueFields.length,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            return Column(
                              children: [
                                CustomTextField(
                                  controller: venueFields[index].controller,
                                  fieldName: venueFields[index].label.toString()+" "+(index+1).toString(),
                                  hintText: "Enter venue...",
                                ),
                                const SizedBox(height: 18),
                              ],
                            );
                          }
                      ),


                      CustomButton(
                        iconHeight: 20,
                        iconColor: AppTheme.darkBackgroundColor,
                        textSize: 14,
                        // width: 35.w,
                        height: 55,
                        iconPath: AppIcons.addIcon,
                        onTap: () async {

                            setState(() {
                              venueFields.add(VenueField(label: "Venue"));
                            });
                        },
                        Text: "Add another venue",
                        borderColor: AppTheme.textfieldBorderColor.withOpacity(.3),
                        buttonColor: AppTheme.primaryColor,
                        textColor: AppTheme.darkBackgroundColor,
                        isAuth: true,
                        isGoogle: false,
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
                            fieldName: "Start Date",
                            hintText: "Select",
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
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
                            fieldName: "End Date",
                            hintText: "Select",
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),
                      CustomButton(
                        onTap: () {
                          Get.back();
                          SnackbarUtil.showSnackbar(
                            message: "Season Created",
                            type: SnackbarType.success,
                          );
                        },
                        Text: "Create Season",
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
