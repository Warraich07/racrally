import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/constants/app_icons.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/views/auth/controller/auth_controller.dart';
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
  final newPasswordController=TextEditingController();
  final confirmNewPasswordController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthController authController=Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon(Icons.arro)
                // SizedBox().setHeight(10.h),
                // GestureDetector(
                //     onTap: (){
                //       Get.back();
                //     },
                //     child: Image.asset(AppIcons.arrow_back_sharp,width: 20,)),
                SizedBox().setHeight(5.h),
                Text("Reset Password",style: AppTheme.subHeadingMediumStyle,),
                Text("Enter your new password",style: AppTheme.bodySmallGreyStyle,),
                SizedBox().setHeight(4.h),
                CustomTextField(
                  controller: newPasswordController,
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
                  controller: confirmNewPasswordController,
                  focusNode: focusNodeConfirmPassword,
                  validator: (value) => CustomValidator.confirmPassword(value,newPasswordController.text.toString()),
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
                // Spacer(),
                SizedBox().setHeight(32.h),
                CustomButton(
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        authController.resetPassword(newPasswordController.text.toString());
                        // Get.offAndToNamed(AppRoutes.login);
                      }
                    },
                    Text: 'Change Password'),
              ],
            ).paddingSymmetric(horizontal: 16,vertical: 50),
          ),
        ),
      ),
    );
  }
}
