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

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  FocusNode focusNodeEmail=FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController=TextEditingController();
  final AuthController authController=Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon(Icons.arro)
              // SizedBox().setHeight(10.h),
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Image.asset(AppIcons.arrow_back_sharp,width: 20,)),
              const SizedBox().setHeight(5.h),
              Text("Forget Password",style: AppTheme.subHeadingMediumStyle,),
              Text("Enter your correct email and you will receive an OTP",style: AppTheme.bodySmallGreyStyle,),
              const SizedBox().setHeight(4.h),
              Form(
                key: _formKey,
                child: CustomTextField(
                  controller: emailController,
                  focusNode: focusNodeEmail,
                  validator: (value) => CustomValidator.email(value),
                  fieldName: "Email",
                  hintText: "Enter your Email",
                ),
              ),
              // Spacer(),
              const SizedBox().setHeight(41.h),
              CustomButton(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      authController.forgetPassword(emailController.text.toString());

                    }
          
                  },
                  Text: 'Send OTP'),
            ],
          ).paddingSymmetric(horizontal: 16,vertical: 50),
        ),
      ),
    );
  }
}
