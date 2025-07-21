import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_widgets/custom_header.dart';
import 'package:racrally/constants/app_icons.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:sizer/sizer.dart';
import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_button.dart';
import '../../constants/app_images.dart';

class SeasonDetailsScreen extends StatefulWidget {
  const SeasonDetailsScreen({super.key});

  @override
  State<SeasonDetailsScreen> createState() => _SeasonDetailsScreenState();
}

class _SeasonDetailsScreenState extends State<SeasonDetailsScreen> {
  List<String> cardImages=[
    AppIcons.games,
    AppIcons.cost,
    AppIcons.raoster,
    AppIcons.competition,
  ];
  List<String> cardText=[
    "Games",
    "Manage Costs",
    "Roaster",
    "Competition",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        children: [
          Stack(
            children: [
              CustomHeader(
                type: " Cricket",
                title: "Football super league",
                subTitle: "27 Jun 2025 - 27 Jul 2025",
                showBody: true,
                body: "Lahore, Punjab, PK, ",
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
                        color: AppTheme.secondaryColor,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AppImages.basketball,scale: 5.3,
                          // color:   widget.forMyProfile==false?AppColors.whiteColor:AppColors.primaryColor,

                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            // color: Colors.yellow,
            height:38.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisAlignment: ,
              children: [
                GridView.builder(
                  padding: EdgeInsets.only(top: 20),
                  shrinkWrap: true,
                  itemCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.8,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        if(index==0){
                          Get.toNamed(AppRoutes.createGame);
                        }
                        print(index);
                      },
                      child: Container(
                        width: 40.w,
                        height: Platform.isIOS?130:110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: AppTheme.textfieldBorderColor.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(cardImages[index],height: 30,width: 30,),
                            SizedBox().setHeight(5),
                            Text(cardText[index],style: AppTheme.bodyMediumStyle,)
                              // Image.asset(name)

                          ],
                        ).paddingOnly(top: 7),
                      ),
                    );
                  },
                ),

              ],
            ).paddingSymmetric(horizontal: 16),
          ),
          CustomButton(

            iconHeight: 20,
            iconColor: AppTheme.darkGreyColor,
            textSize: 14,
            // width: 35.w,
            height: 64,
            iconPath: AppIcons.alarm,
            onTap: () async {

            },
            Text: "Manage Reminders",
            borderColor: AppTheme.textfieldBorderColor.withOpacity(.3),
            buttonColor: AppTheme.primaryColor,
            textColor: AppTheme.darkBackgroundColor,
            isAuth: true,
            isGoogle: false,
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }
}
