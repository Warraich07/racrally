import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/width_extension.dart';

import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';


class CustomEventCard extends StatefulWidget {
  const CustomEventCard({super.key});

  @override
  State<CustomEventCard> createState() => _CustomEventCardState();
}

class _CustomEventCardState extends State<CustomEventCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius:  BorderRadius.circular(12),
          border: Border.all(width: 1,color: AppTheme.textfieldBorderColor.withOpacity(0.3))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 1,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppTheme.extraLightGreyColor
                ),
                child: Text("Saturday, June 22 – 5:00 PM",style: AppTheme.bodyExtraSmallFontWeight500Style,),
              ),
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
          const Spacer(flex: 2,),
          Text("Annual Team Lunch",style: AppTheme.bodyMediumFont600Style,),
          const Spacer(flex: 1,),
          Text("Maplewood Park – Field 3",style: AppTheme.bodyExtraSmallStyle.copyWith(color: AppTheme.darkBackgroundColor),),
        ],
      ).paddingSymmetric(horizontal: 10,vertical: 10),
    ).paddingOnly(bottom: 10);
  }
}
