

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/constants/app_icons.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:sizer/sizer.dart';

import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_button.dart';
import '../../app_widgets/custom_text_field.dart';
import '../../constants/custom_validators.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  FocusNode focusNodeEmail=FocusNode();
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
              child: Image.asset(AppIcons.arrow_back_sharp,width: 20,)),
          SizedBox().setHeight(5.h),
          Text("Forget Password",style: AppTheme.subHeadingMediumStyle,),
          Text("Enter your correct email and you will receive an OTP",style: AppTheme.bodySmallGreyStyle,),
          SizedBox().setHeight(4.h),
          CustomTextField(focusNode: focusNodeEmail,validator: (value) => CustomValidator.email(value),fieldName: "Email",hintText: "Enter your Email",),
          Spacer(),
          CustomButton(
              onTap: (){
                Get.toNamed(AppRoutes.verifyOtp);
              },
              Text: 'Send OTP'),
        ],
      ).paddingSymmetric(horizontal: 16,vertical: 50),
    );
  }
}
