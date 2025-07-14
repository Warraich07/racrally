import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_widgets/custom_text_field.dart';
import 'package:racrally/extensions/alignment_extension.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import 'package:racrally/views/auth/controller/auth_controller.dart';
import 'package:racrally/views/auth/widgets/custom_dropdown.dart';
import 'package:sizer/sizer.dart';

import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_button.dart';
import '../../constants/app_images.dart';
import '../../constants/custom_validators.dart';
import '../../routes/app_routes.dart';
import '../../utils/snackbar_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController authController=Get.find();
  bool showPassword=true;
  bool showCheck=false;
  String? selectedGender;
  FocusNode focusNodeFirstName=FocusNode();
  FocusNode focusNodeLastName=FocusNode();
  FocusNode focusNodeEmail=FocusNode();
  FocusNode focusNodePassword=FocusNode();
  FocusNode focusNodeGender=FocusNode();
  final firstNameController=TextEditingController();
  final lastNameController=TextEditingController();
  final emailController=TextEditingController();
  final genderController=TextEditingController();
  final passwordController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Create Your Account",
                      style: AppTheme.headingStyle,
                    ),
                    Text(
                      "Create account to build, manage, and rally your squad!",
                      style: AppTheme.bodySmallStyle,

                    ),
                  ],
                ).paddingOnly(left: 16, right: 16),
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
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          controller: firstNameController,
                          focusNode: focusNodeFirstName,
                          validator: (value) => CustomValidator.firstName(value),
                          fieldName: "First Name",
                          hintText: "Enter first name...",)),
                        SizedBox().setWidth(10),
                        Expanded(child: CustomTextField(
                          controller: lastNameController,
                          focusNode: focusNodeLastName,
                          validator: (value) => CustomValidator.lastName(value),
                          fieldName: "Last Name",
                          hintText: "Enter last name...",)),

                      ],
                    ),
                    SizedBox().setHeight(18),
                    CustomTextField(
                      controller: emailController,
                      validator: (value) => CustomValidator.email(value),
                      focusNode: focusNodeEmail,
                      fieldName: "Email",hintText: "Enter your Email",),
                    const SizedBox().setHeight(18),
                    // dropdown
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


                    // CustomDropDown(hintText: hintText, dropDownData: dropDownData, icon: icon, onChanged: onChanged, selectedValue: selectedValue)
                    const SizedBox().setHeight(18),

                    CustomTextField(
                      controller: passwordController,
                      validator: (value) => CustomValidator.password(value),
                      focusNode: focusNodePassword,
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
                            setState(() {
                              showCheck=!showCheck;
                            });

                            // authController.toggleCheck();
                          },
                          child:  Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  width: 2,
                                  color: AppTheme.textfieldBorderColor.withOpacity(0.3),
                                ),
                              ),
                              child:  showCheck? Icon(Icons.check, size: 13,color:  AppTheme.secondaryColor,).paddingAll(1):Container(),
                            ),

                        ),
                        const SizedBox().setWidth(5),
                        Text("I agree with Privacy Policy and Term & Conditions", style: AppTheme.bodyExtraSmallStyle),

                      ],
                    ),
                    const SizedBox().setHeight(14),
                    CustomButton(
                        onTap: (){
                          if(_formKey.currentState!.validate()){
                          if(showCheck==false){
                            SnackbarUtil.showSnackbar(message: "Please select terms and conditions", type: SnackbarType.warning);
                          }else{
                            focusNodeFirstName.unfocus();
                            focusNodeLastName.unfocus();
                            focusNodeEmail.unfocus();
                            focusNodePassword.unfocus();
                            authController.signUpUser(
                                firstNameController.text.toString(),
                                lastNameController.text.toString(),
                                emailController.text.toString(),
                                passwordController.text.toString(),
                               selectedGender!,);
                          }

                          }
                          // authController.signUpUser("talha", "zubair", "tala112@gmail.com", "12345678", "Male");
                        },
                        Text: 'Sign Up'),
                    const SizedBox().setHeight(14),
                    Row(
                      children: [
                         Expanded(child: Divider(
                          color: AppTheme.textfieldBorderColor.withOpacity(0.3),
                        ),),
                        Text(
                          "Or Sign Up with",
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
                        if(_formKey.currentState!.validate()){
                          print("object");
                        }
                      },
                      Text: "Google",
                      borderColor: AppTheme.textfieldBorderColor.withOpacity(.3),
                      buttonColor: AppTheme.primaryColor,
                      textColor: AppTheme.darkBackgroundColor,
                      isAuth: true,
                    ),
                    const SizedBox().setHeight(14),
                    CustomButton(
                      onTap: (){},
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
                        Text("Already have an account?",style: AppTheme.bodySmallGreyStyle,),
                        GestureDetector(
                          onTap: (){

                            Get.offAndToNamed(AppRoutes.login);
                          },
                          child: Text(
                            "Sign In",
                            style: AppTheme.bodySmallStyleFont600.copyWith(
                              color: AppTheme.secondaryColor,
                            ),
                          ).paddingOnly(left: 5),
                        ),
                      ],
                    )

                  ],
                ).paddingOnly(left: 16, right: 16, top: 32,bottom: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
