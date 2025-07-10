import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';

import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';

class CustomTeamCard extends StatefulWidget {
  const CustomTeamCard({super.key});

  @override
  State<CustomTeamCard> createState() => _CustomTeamCardState();
}

class _CustomTeamCardState extends State<CustomTeamCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 90.w,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.primaryDarkColor,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 18,
              width: 77,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: AppTheme.primaryCardColor
              ),
              child: Center(child: Text("Next Game",style: AppTheme.bodyExtraSmallFontTenStyle,)),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Center(child: Text('July\n 24',style: AppTheme.bodySmallStyleFont600.copyWith(color: AppTheme.darkBackgroundColor),)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 3, // thickness
                height: 40, // or whatever height you want
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor,
                  borderRadius: BorderRadius.circular(8), // desired radius
                ),
              ),
              // SizedBox().setWidth(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("vs",style: AppTheme.bodySmallGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),),
                      Text("Thunder Bolt",style: AppTheme.bodyMediumFont600Style,)
                    ],
                  ),
                  const SizedBox().setHeight(5),
                  Row(
                    children: [
                      Text("Maplewood Park – Field 3",style: AppTheme.bodyExtraSmallStyle.copyWith(color:AppTheme.darkBackgroundColor ),),

                    ],
                  ),
                  const SizedBox().setHeight(5),
                  Row(
                    children: [
                      Row(
                        children: [ Image.asset(AppIcons.accepted,height: 18,width: 18,),const SizedBox().setWidth(3),Text("12",style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
                      ),
                      const SizedBox().setWidth(5),
                      Row(
                        children: [ Image.asset(AppIcons.cancelled,height: 18,width: 18,),const SizedBox().setWidth(3),Text("05",style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
                      ),
                      const SizedBox().setWidth(5),
                      Row(
                        children: [ Image.asset(AppIcons.pending,height: 18,width: 18,),const SizedBox().setWidth(3),Text("10",style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
                      )
                    ],
                  ),


                ],
              ),
              const Spacer(),
              Text("8:00PM",style: AppTheme.bodyExtraSmallStyle,)
            ],
          ).paddingSymmetric(horizontal: 12)
        ],
      ),
    );
  }
}
