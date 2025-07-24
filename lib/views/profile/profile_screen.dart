import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_widgets/custom_text_field.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:racrally/views/auth/controller/auth_controller.dart';
import 'package:racrally/views/profile/widgets/profile_screen.dart';
import 'package:sizer/sizer.dart';

import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_button.dart';
import '../../app_widgets/custom_header.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_images.dart';
import '../../constants/custom_validators.dart';
import '../../services/local_storage/shared_preferences.dart';
import '../../utils/custom_dialog.dart';
import '../auth/widgets/custom_dropdown.dart';
import '../team/widgets/create_team_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedGender;
  final AuthPreference _authPreference = AuthPreference.instance;
  AuthController authController=Get.find();
  final emailController=TextEditingController();
  final nameController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      emailController.text=authController.userData.value!.email;
      nameController.text=authController.userData.value!.firstName.capitalizeFirst!+" "+authController.userData.value!.lastName.capitalizeFirst!;
      selectedGender=authController.userData.value!.gender;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height:Platform.isIOS?30.h: 35.h,
                child: Stack(
                  children: [
                    CustomHeader(
                      showBackArrow: true,
                      showPopUpMenu: false,
                      title: authController.userData.value!.firstName.capitalizeFirst!+" "+authController.userData.value!.lastName.capitalizeFirst!,
                      showSubtitle: false,
                      onMenuSelected: (value) {
                        if (value == 'edit') {
                          // CreateTeamSheet.show(context, true);
                          print("Edit selected");
                        } else if (value == 'delete') {
                          print("Delete selected");
                        } else if (value == 'send rsvp') {
                          CustomDialog.showReminderDialog(iconPath: AppIcons.share);
                        }
                      },
                    ),
                    Positioned(
                      top: 20.h - 50, // adjust this to control how much overlaps
                      left: MediaQuery.of(context).size.width / 2 - 50,
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                AppIcons.userIcon, // use your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height:Platform.isIOS?40.h: 29.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox().setHeight(5),
                      CustomTextField(
                        controller: nameController,
                        fieldName: "Name",
                        hintText: "Talha Warraich",
                      ),
                      const SizedBox().setHeight(18),
                      CustomTextField(
                        controller: emailController,
                        fieldName: "Email",
                        hintText: "talha@gmail.com",
                      ),
                      const SizedBox().setHeight(18),
                      CustomDropdownField(
                        validator: (value) => CustomValidator.selectGenderRange(value),
                        fieldName: "Gender",
                        hintText: "Select gender",
                        value: selectedGender,
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("Male")),
                          DropdownMenuItem(value: "Female", child: Text("Female")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      const SizedBox().setHeight(18),
                      Container(
                        decoration: BoxDecoration(
                            color: AppTheme.darkGreyColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          children: [
                            CustomTile(title: "Allow Notifications",isNotificationTile:true),
                            CustomTile(title: "Privacy Policy",),
                            CustomTile(title: "Terms & Conditions",),
                            CustomTile(title: "Contact Us",),
                            CustomTile(title: "Rate Us",),
                          ],
                        ).paddingOnly(top: 5),
                      )
                    ],
                  ).paddingOnly(left: 16,right: 16,bottom: 16),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: AppTheme.primaryColor,
              width: 92.w,
              child: Column(

                children: [
                  SizedBox().setHeight(10),
                  CustomButton(
                    onTap: () {
                        CustomDialog.showDeleteDialog(

                          showIcon: false,
                          title: "Logout",
                          description: "Are you sure you want to logout?",
                          confirmText: "Yes",
                          onConfirm: (){
                            _authPreference.setUserLoggedIn(false);
                            Get.offAndToNamed(AppRoutes.login);
                          }
                        );
                    },
                    Text: "",
                    borderColor: AppTheme.textfieldBorderColor.withOpacity(.3),
                    buttonColor: AppTheme.primaryColor,
                    textColor: AppTheme.darkBackgroundColor,
                    isAuth: true,
                    isGoogle: false,
                    isOnBoarding: true,
                    onBoardingText: Text("Logout"),
                  ),
                  SizedBox().setHeight(10),
                  CustomButton(
                    onTap: () {
              
                    },
                    Text: "",
                    borderColor: AppTheme.textfieldBorderColor.withOpacity(.3),
                    buttonColor: AppTheme.primaryColor,
                    textColor: AppTheme.darkBackgroundColor,
                    isAuth: true,
                    isGoogle: false,
                    isOnBoarding: true,
                    onBoardingText: Text("Change Password"),
                  ),
                  SizedBox().setHeight(10),
                  CustomButton(
                    onTap: () {

                    },
                    Text: "",
                    borderColor: AppTheme.textfieldBorderColor.withOpacity(.3),
                    buttonColor: AppTheme.primaryColor,
                    textColor: AppTheme.darkBackgroundColor,
                    isAuth: true,
                    isGoogle: false,
                    isOnBoarding: true,
                    onBoardingText: Text("Delete Account"),
                  ),
                  SizedBox().setHeight(10),
                  CustomButton(Text: "Save Changes"),
                  
                  SizedBox(height: Platform.isIOS?20:0,)
                ],
              ),
            ).paddingAll(16),
          )
        ],
      ),
    );
  }
}
