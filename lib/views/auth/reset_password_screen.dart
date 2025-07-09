import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/constants/app_icons.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:sizer/sizer.dart';
import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_button.dart';
import '../../app_widgets/custom_text_field.dart';
import '../../constants/custom_validators.dart';
import '../../routes/app_routes.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool showNewPassword=true;
  bool showConfirmPassword=true;
  FocusNode focusNodeNewPassword=FocusNode();
  FocusNode focusNodeConfirmPassword=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon(Icons.arro)
          // SizedBox().setHeight(10.h),
          GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Image.asset(AppIcons.back_arrow,width: 24,)),
          SizedBox().setHeight(5.h),
          Text("Reset Password",style: AppTheme.subHeadingMediumStyle,),
          Text("Enter your new password",style: AppTheme.bodySmallGreyStyle,),
          SizedBox().setHeight(4.h),
          CustomTextField(
            focusNode: focusNodeNewPassword,
            validator: (value) => CustomValidator.password(value),
            suffixIcon: showNewPassword?GestureDetector(
                onTap: (){
                  setState(() {showNewPassword=!showNewPassword;});
                },
                child: Icon(Icons.remove_red_eye_rounded)):GestureDetector(
                onTap: (){
                  setState(() {showNewPassword=!showNewPassword;});
                },
                child: Icon(Icons.remove_red_eye_outlined)),
            isObscure:showNewPassword?true:false,
            fieldName: "New Password",
            hintText: "Enter your Password",
          ),
          const SizedBox().setHeight(18),
          CustomTextField(
            focusNode: focusNodeConfirmPassword,
            validator: (value) => CustomValidator.confirmPassword(value,''),
            suffixIcon: showConfirmPassword?GestureDetector(
                onTap: (){
                  setState(() {showConfirmPassword=!showConfirmPassword;});
                },
                child: Icon(Icons.remove_red_eye_rounded)):GestureDetector(
                onTap: (){
                  setState(() {showConfirmPassword=!showConfirmPassword;});
                },
                child: Icon(Icons.remove_red_eye_outlined)),
            isObscure:showConfirmPassword?true:false,
            fieldName: "Confirm Password",
            hintText: "Enter your Password",
          ),
          Spacer(),
          CustomButton(
              onTap: (){
                Get.offAndToNamed(AppRoutes.login);
              },
              Text: 'Change Password'),
        ],
      ).paddingSymmetric(horizontal: 16,vertical: 50),
    );
  }
}
