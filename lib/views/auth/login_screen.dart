import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_widgets/custom_text_field.dart';
import 'package:racrally/constants/custom_validators.dart';
import 'package:racrally/extensions/alignment_extension.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import 'package:racrally/views/auth/controller/auth_controller.dart';
import 'package:racrally/views/auth/controller/social_sign_in_controller.dart';
import 'package:racrally/views/bottom_nav_bar/controller/bottom_bar_controller.dart';
import 'package:sizer/sizer.dart';

import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_button.dart';
import '../../constants/app_images.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController=Get.find();
  final GeneralController generalController=Get.find();
  final SocialSignInController socialSignInController=Get.find();
  bool showPassword=true;
  bool rememberMe=false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode focusNodeEmail=FocusNode();
  FocusNode focusNodePassword=FocusNode();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppTheme.secondaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// Image and header
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    AppImages.topbar_ellipses,
                    height: 30.h,
                  ).alignTopRight(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to RecRally",
                        style: AppTheme.headingStyle,
                      ),
                      Text(
                        "Log in to continue organizing your league like a pro",
                        style: AppTheme.bodySmallStyle,

                      ),
                    ],
                  ).paddingOnly(left: 16, right: 16,top: Platform.isIOS?80:0),
                ],
              ),

              /// Scrollable Form Container
              Container(
                width: 100.w,
                margin: const EdgeInsets.only(top: 32),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: AppTheme.primaryColor,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      CustomTextField(
                        controller: emailController,
                        focusNode: focusNodeEmail,
                        validator: (value) => CustomValidator.email(value),
                        fieldName: "Email",hintText: "Enter your Email",),
                      const SizedBox().setHeight(18),
                            CustomTextField(
                              controller: passwordController,
                              focusNode: focusNodePassword,
                              validator: (value) => CustomValidator.password(value),
                              suffixIcon: showPassword?GestureDetector(
                                  onTap: (){

                                    setState(() {
                                      showPassword=!showPassword;
                                    });
                                  },
                                  child: Icon(Icons.remove_red_eye_rounded)):GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      showPassword=!showPassword;
                                    });
                                  },
                                  child: Icon(Icons.remove_red_eye_outlined)),
                          isObscure:showPassword?true:false,
                          fieldName: "Password",
                          hintText: "Enter your Password",
                          // suffixIcon: GestureDetector(
                          //     onTap: (){
                          //       authController.togglePassword();
                          //     },
                          //     child:authController.showPassword.value? Icon(Icons.remove_red_eye_rounded):Icon(Icons.remove_red_eye_outlined)),
                            ),
                      const SizedBox().setHeight(12),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              print("object");
                              setState(() {
                                rememberMe=!rememberMe;
                              });

                            },
                            child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    width: 2,
                                    color: AppTheme.textfieldBorderColor.withOpacity(0.3),
                                  ),
                                ),
                                child:  rememberMe? Icon(Icons.check, size: 13,color:  AppTheme.secondaryColor,).paddingAll(1):Container(),
                              ),

                          ),
                          const SizedBox().setWidth(5),
                          Text("Remember me", style: AppTheme.bodyExtraSmallStyle),
                          const Spacer(),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoutes.forgetPassword);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: AppTheme.bodyExtraSmallStyle.copyWith(
                                color: AppTheme.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox().setHeight(14),
                      CustomButton(
                      onTap: ()async{
                        if(_formKey.currentState!.validate()){
                          focusNodeEmail.unfocus();
                          focusNodePassword.unfocus();
                        await  authController.loginUser(emailController.text.toString(), passwordController.text.toString(),rememberMe);
                          print("object");
                          // Get.offAndToNamed(AppRoutes.bottomBar);
                        }

                        // generalController.onBottomBarTapped(0);
                      },
                      Text: 'Sign In'),
                      const SizedBox().setHeight(14),
                      Row(
                        children: [
                           Expanded(child: Divider(
                            color: AppTheme.textfieldBorderColor.withOpacity(0.3),
                          ),),
                          Text(
                            "Or Sign In with",
                            style: AppTheme.bodySmallGreyStyle,
                          ).paddingSymmetric(horizontal: 20),
                           Expanded(child: Divider(
                            color: AppTheme.textfieldBorderColor.withOpacity(0.3),
                          ),),
                        ],
                      ),
                      const SizedBox().setHeight(18),
                       CustomButton(
                          onTap: (){
                            socialSignInController.signInWithGoogle();
                          },
                         Text: "Google",
                         borderColor: AppTheme.textfieldBorderColor.withOpacity(.3),
                         buttonColor: AppTheme.primaryColor,
                         textColor: AppTheme.darkBackgroundColor,
                         isAuth: true,
                       ),
                      const SizedBox().setHeight(14),
                       CustomButton(
                         onTap: (){
                           socialSignInController.signInWithFacebook();
                         },
                         Text: "Facebook",
                         borderColor: AppTheme.textfieldBorderColor.withOpacity(.3),
                         buttonColor: AppTheme.primaryColor,
                         textColor: AppTheme.darkBackgroundColor,
                         isAuth: true,
                         isGoogle: false,
                       ),
                      const SizedBox().setHeight(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account yet?",style: AppTheme.bodySmallGreyStyle,),
                          GestureDetector(
                            onTap: (){
                              Get.offAndToNamed(AppRoutes.signUp);
                            },
                            child: Text(
                              "Sign Up",
                              style: AppTheme.bodySmallStyleFont600.copyWith(
                                color: AppTheme.secondaryColor,
                              ),
                            ).paddingOnly(left: 5),
                          ),
                        ],
                      ),
                      SizedBox(height:Platform.isIOS? 20:0,)
                    ],
                  ).paddingOnly(left: 16, right: 16, top: 32,bottom: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
