import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:racrally/constants/app_icons.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:sizer/sizer.dart';
import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_button.dart';
import '../../constants/custom_validators.dart';
import '../../utils/snackbar_utils.dart';
import 'controller/auth_controller.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final FocusNode _otpFocusNode = FocusNode();
  final AuthController authController=Get.find();

  String otp = "";
  bool showMessage = false;
  late Timer _timer;
  int _countdown = 30;
  bool _resendVisible = false;
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          // Timer reached zero, enable resend button
          _timer.cancel();
          _resendVisible = true;
        }
      });
    });
  }

  void resendOtp() {
    // Logic to resend OTP, e.g., make API call
    setState(() {
      _countdown = 30; // Reset countdown
      _resendVisible = false; // Hide resend button
    });
    startTimer(); // Start the timer again
  }


  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
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
          Text("Enter Your OTP",style: AppTheme.subHeadingMediumStyle,),
          Text("Enter your OTP you got on your email",style: AppTheme.bodySmallGreyStyle,),
          SizedBox().setHeight(4.h),
          Form(
            key: _formKey,
            child: Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: InputDecorationTheme(
                  errorStyle: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondaryColor,

                  ),
                ),
              ),
              child: PinCodeTextField(

                validator: (value) => CustomValidator.otp(value),
                focusNode: _otpFocusNode,
                appContext: context,
                length: 4,
                obscureText: false,
                animationType: AnimationType.none,
                cursorColor: Colors.black,
                textStyle:  TextStyle(fontSize: 16,fontFamily: "medium",color: AppTheme.darkBackgroundColor),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 48,
                  fieldWidth: 62,
                  borderWidth: 1,
                  activeColor: AppTheme.textfieldBorderColor.withOpacity(.3), // 👈 Border color when filled and active
                  inactiveColor: AppTheme.textfieldBorderColor.withOpacity(.3), // 👈 Border color when empty/inactive
                  selectedColor: AppTheme.secondaryColor, // 👈 Border color when selected/focused
                  activeFillColor: AppTheme.primaryColor,
                  inactiveFillColor: AppTheme.primaryColor,
                  selectedFillColor: AppTheme.primaryColor,
                ),
                enableActiveFill: true,
                onChanged: (String value) {
                  setState(() {
                    otp = value;
                  });
                },
                onCompleted: (String value) {
                  setState(() {
                    otp = value;
                    print("Completed OTP: $otp");
                    _otpFocusNode.unfocus();
                  });
                },
              ),
            ),
          ),
          // Row(
          //   children: [
          //     otp.isEmpty? Text("Enter otp",style: TextStyle(fontSize: 10,color:AppTheme.secondaryColor,fontWeight: FontWeight.bold),):
          //     otp.length<4?Text("Enter otp",style: TextStyle(fontSize: 10,color:AppTheme.secondaryColor,fontWeight: FontWeight.bold),):Container(),
          //   ],
          // ),
          _resendVisible
              ? Row(
                children: [
                  Text("Did’nt receive? ",style: AppTheme.bodyMediumGreyStyle,),
                  GestureDetector(
                  onTap: () {
                    _otpFocusNode.unfocus();
                    resendOtp();
                  },
                  child:  Center(
                      child: Text(
                        "Resend",
                          style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.secondaryColor),))),
                ],
              )
              :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                 "Resend Code in",
                style: AppTheme.bodyMediumGreyStyle,
              ),
              Text(
                _resendVisible ? '' : ' 00:${_countdown.toString().padLeft(2, '0')}', // Use padLeft to format
                style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.secondaryColor),
              ),
            ],
          ),
          Spacer(),
          CustomButton(
              onTap: (){
                if(_formKey.currentState!.validate()){
                  _otpFocusNode.unfocus();
                  authController.verifyEmail(otp);
                }
                // if(otp.isEmpty){
                //   SnackbarUtil.showSnackbar(message: "Please enter OTP", type: SnackbarType.info);
                // }else if(otp.length<4){
                //   SnackbarUtil.showSnackbar(message: "Please enter valid OTP code", type: SnackbarType.info);
                // }
                // Get.toNamed(AppRoutes.resetPassword);
              },
              Text: 'Next'),
        ],
      ).paddingSymmetric(horizontal: 16,vertical: 50),
    );
  }
}
