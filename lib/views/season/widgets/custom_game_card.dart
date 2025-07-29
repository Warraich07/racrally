import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_theme.dart';
import '../../../constants/app_images.dart';

class CustomGameCard extends StatelessWidget {
  const CustomGameCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 114,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: AppTheme.textfieldBorderColor.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          height: 60,
                          width: 60,
                          color: AppTheme.darkBackgroundColor,
                          child: Image.asset(AppImages.basketball)),
                    ),
                    Text("Taha XI",style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("5:00 PM",style: AppTheme.bodyExtraSmallStyle.copyWith(color: AppTheme.secondaryColor),),
                    Row(
                      children: [
                        Text("0",style: AppTheme.headingStyleFont600,),
                        Container(
                          height: 24,width: 2,
                          color: AppTheme.dividerColor,
                        ).paddingSymmetric(horizontal: 5),
                        Text("0",style: AppTheme.headingStyleFont600,),
                      ],
                    ),
                    Text("19 June, 2025",style: AppTheme.bodyExtraSmallStyle,)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          height: 60,
                          width: 60,
                          color: AppTheme.darkBackgroundColor,
                          child: Image.asset(AppImages.basketball)),
                    ),
                    Text("Taha XI",style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),)
                  ],
                ),
              ],
            ).paddingOnly(left: 16,right: 16,top: 6)
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 18,
            width: 110,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: AppTheme.lightGreyColor.withOpacity(.1)
            ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "In: 12  ",
                      style: AppTheme.bodyExtraSmallFontWeight500Style.copyWith(color: AppTheme.primaryCardColor),
                    ),
                    TextSpan(
                      text: "NR: 4  ",
                      style:  AppTheme.bodyExtraSmallFontWeight500Style.copyWith(color: AppTheme.red),
                    ),
                    TextSpan(
                      text: "Subs: 5",
                      style:  AppTheme.bodyExtraSmallFontWeight500Style.copyWith(color: AppTheme.darkGreyColor),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
