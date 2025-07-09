import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_theme/app_theme.dart';
import 'package:racrally/constants/app_icons.dart';
import 'package:racrally/constants/app_images.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';

import '../../app_widgets/custom_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: (){
                    Get.back();},
                  child: Image.asset(AppIcons.back_arrow,width: 24,)),
              Text("Pending Requests",style: AppTheme.mediumHeadingStyle,),
              Container(width: 50,)
            ],
          ).paddingOnly(left: 16,right: 16),
          Container(
            height: 100,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox().setHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(

                      children: [
                        Image.asset(AppIcons.userIcon,height: 35,width: 35,),
                        SizedBox().setWidth(5),
                        Text("Phoenix Baker",style: AppTheme.bodyMediumStyle,),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                      color: Color(0xFFEC4F47).withOpacity(.1)
                      //         Color(0xFF16B364),
                      // Color(0xFFEC4F47),
                          ),
                          child: Icon(Icons.clear,size: 20,color: Color(0xFFEC4F47),),
                        ),
                        SizedBox().setWidth(5),
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xFF16B364).withOpacity(.1)
                            //         Color(0xFF16B364),
                            // Color(0xFFEC4F47),
                          ),
                          child: Icon(Icons.check,size: 20,color: Color(0xFF16B364),),
                        )
                      ],
                    )
                  ],
                ).paddingOnly(left: 16,right: 16),
                Divider(
                  color: AppTheme.textfieldBorderColor.withOpacity(.3),
                )
              ],
            ),
          ),
          Spacer(),
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
            onBoardingText: Text("Clear All"),
          ).paddingOnly(left: 16,right: 16,bottom: 20)
        ],
      ).paddingOnly(top: 30),
    );
  }
}
