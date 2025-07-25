import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:racrally/constants/app_icons.dart';
import 'package:racrally/constants/app_images.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:racrally/views/team/controller/team_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../app_theme/app_theme.dart';
import '../../../app_widgets/custom_button.dart';
import '../../../app_widgets/custom_text_field.dart';
import '../../../constants/custom_validators.dart';
import '../../../utils/snackbar_utils.dart';

class CreateTeamSheet {
  static Color _parseColorFromString(String colorString) {
    final valueString = colorString.split('(0x')[1].split(')')[0];
    return Color(int.parse(valueString, radix: 16));
  }

  static void show(BuildContext context,bool isUpdate,String? name, String? location,String? pathImage,String colorOfTeam,String? teamId) {

    File? _pickedImage;
    int selectedIndex = -1;
    final TeamController teamController=Get.find();
    final GlobalKey<FormState> _formKey = GlobalKey();
    final teamNameController=TextEditingController();
    final locationController=TextEditingController();
    final focusNodeTeamName=FocusNode();
    final focusNodeLocation=FocusNode();
     XFile? image;
     String imagePath='';
     String teamColor='';
     String editImagePath='';
    List<Color> teamColors=[
      Color(0xFFD93229),
      Color(0xFF00C352),
      Color(0xFFFBBC05),
      Color(0xFF4285F4),
      Color(0xFF19AFFF),
      Color(0xFF9719FF),
    ];
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
            print(colorOfTeam);
            if (isUpdate == true && !isInitialized) {
              teamNameController.text = name ?? '';
              locationController.text = location ?? '';
              editImagePath = pathImage ?? '';
              teamColor = colorOfTeam;

              // Match or add colorOfTeam to teamColors
              try {
                // Parse the string back to Color
                Color parsedColor = _parseColorFromString(colorOfTeam);

                // Check if it already exists in the list
                final matchIndex = teamColors.indexWhere((c) => c.value == parsedColor.value);
                if (matchIndex != -1) {
                  selectedIndex = matchIndex;
                } else {
                  teamColors.add(parsedColor);
                  selectedIndex = teamColors.length - 1;
                }
              } catch (e) {
                print('Error parsing color: $e');
              }

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
                                    :editImagePath.isNotEmpty? Container(
                                  height: 100,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.darkBackgroundColor,
                                  ),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:editImagePath,
                                      placeholder: (context, url) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                color: AppTheme.secondaryColor,
                                              )),
                                      errorWidget: (context, url,
                                          error) =>
                                          Image.asset(
                                            AppImages.topbar_ellipses,scale: 5.3,
                                          ),
                                      fit: BoxFit.cover,
                                      // scale:20 ,
                                    ),
                                  ),
                                ):
                                Image.asset(
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
                        CustomTextField(
                          focusNode: focusNodeTeamName,
                          controller: teamNameController,
                          validator: (value) => CustomValidator.team(value),
                          fieldName: "Team Name",
                          hintText: "Enter team name...",
                        ),
                        const SizedBox(height: 18),
                        CustomTextField(
                          focusNode: focusNodeLocation,
                          controller: locationController,
                          validator: (value) => CustomValidator.location(value),
                          fieldName: "Location",
                          hintText: "Enter address...",
                        ),
                        const SizedBox(height: 18),
                        Container(
                          width: double.infinity,
                            height: 92,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 1,
                                color: AppTheme.textfieldBorderColor.withOpacity(.3),
                              ),
                        ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Team Color",
                              style: AppTheme.bodyExtraSmallWeight400Style.copyWith(
                                color: AppTheme.darkBackgroundColor
                              ),
                              ).paddingOnly(left: 16,right: 16,),
                              SizedBox().setHeight(10),
                              SizedBox(
                                height: 40,
                                child: ListView.builder(
                                  padding: EdgeInsets.only(left: 16),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: teamColors.length + 1, // +1 for the icon
                                  itemBuilder: (context, index) {
                                    if (index == teamColors.length) {
                                      // Color Picker Icon
                                      return GestureDetector(
                                        onTap: () async {
                                          Color pickerColor = Colors.red;
                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: AppTheme.primaryColor,
                                                title: const Text('Pick a color'),
                                                content: SingleChildScrollView(
                                                  child: ColorPicker(
                                                    pickerColor: pickerColor,
                                                    onColorChanged: (color) {
                                                      pickerColor = color;
                                                    },
                                                    enableAlpha: false,
                                                    pickerAreaHeightPercent: 0.8,
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.of(context).pop(),
                                                    child:  Text(
                                                      'Cancel',
                                                      style: AppTheme.bodyExtraSmallStyle.copyWith(color: AppTheme.secondaryColor),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed:(){
                                                      print(pickerColor.toString());

                                                      print(teamColors);
                                                      setState(() {
                                                        teamColors.add(pickerColor);
                                                        selectedIndex = teamColors.length - 1;
                                                        teamColor = pickerColor.toString();
                                                        Get.back();
                                                      });
                                                    },
                                                    child:  Text(
                                                      'Select',
                                                      style: AppTheme.bodyExtraSmallStyle.copyWith(color: AppTheme.secondaryColor),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          // Add picked color and select it
                                          // setState(() {
                                          //   teamColors.add(pickerColor);
                                          //   selectedIndex = teamColors.length - 1;
                                          //   teamColor = pickerColor.toString();
                                          // });
                                        },

                                        child: Container(
                                          margin: const EdgeInsets.only(right: 8),
                                          height: 38,
                                          width: 38,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(22),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.15),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Image.asset(
                                            AppIcons.color_picker,
                                            height: 36,
                                            width: 36,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      );
                                    }

                                    // Color Dot
                                    final isSelected = selectedIndex == index;
                                    return GestureDetector(
                                      onTap: () {
                                        focusNodeTeamName.unfocus();
                                        focusNodeLocation.unfocus();
                                        setState(() {
                                          selectedIndex = index;
                                          teamColor = teamColors[index].toString();
                                        });
                                        print("Selected index: $index");
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 6),
                                        padding: const EdgeInsets.all(5),
                                        height: 30,
                                        width: 38,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(22),
                                          color: isSelected ? AppTheme.primaryColor : teamColors[index],
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          height: 27,
                                          width: 27,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: teamColors[index],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )



                            ],
                          ).paddingOnly(top: 10,bottom: 6),
                        ),
                        const SizedBox(height: 18),
                        CustomButton(
                          onTap: () {
                            if(_formKey.currentState!.validate()){
                              if(imagePath.isEmpty &&isUpdate==false){
                                SnackbarUtil.showSnackbar(message: "Please select image", type: SnackbarType.info);
                              }else if(selectedIndex==-1){
                                SnackbarUtil.showSnackbar(message: "Please select team color", type: SnackbarType.info);
                              }else if(isUpdate==true){
                                teamController.editTeam(teamId!, teamNameController.text.toString(), locationController.text.toString(), teamColor, imagePath);
                              }
                              else{
                                teamController.createTeam(teamNameController.text.toString(), locationController.text.toString(), teamColor, imagePath);
                              }
                            }

                          },
                          Text:isUpdate?'Update': "Create Team",
                        ),
                        SizedBox(height: Platform.isIOS?20:0,)
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
