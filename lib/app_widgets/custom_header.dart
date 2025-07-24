import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../app_theme/app_theme.dart';
import '../constants/app_icons.dart';
import '../utils/custom_dialog.dart';
import '../views/team/widgets/create_team_sheet.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    this.title,
    this.subTitle,
    this.showSubtitle,
    this.showBody,
    this.showPopUpMenu,
    this.showBackArrow,
    this.onMenuSelected,
    this.body,
    this.type,
  });

  final String? title;
  final String? subTitle;
  final String? body;
  final String? type;
  final bool? showSubtitle;
  final bool? showBody;
  final bool? showPopUpMenu;
  final bool? showBackArrow;
  final void Function(String)? onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:showBody==true?39.h: 36.h,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 20.h,
            decoration: BoxDecoration(
              color: AppTheme.primaryDarkColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Platform.isIOS?30:0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showBackArrow==true?GestureDetector(
                        onTap:(){
                          Get.back();
                        },
                        child: Image.asset(AppIcons.arrow_back_sharp,width: 20,)):Container(),
                    showPopUpMenu == false
                        ? Container()
                        : Theme(
                      data: Theme.of(context).copyWith(
                        popupMenuTheme: PopupMenuThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      child: PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert),
                        color: AppTheme.primaryColor,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Image.asset(AppIcons.edit, height: 20, width: 20),
                                const SizedBox(width: 10),
                                Text('Edit', style: AppTheme.bodyMediumGreyStyle),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Image.asset(AppIcons.delete, height: 20, width: 20),
                                const SizedBox(width: 10),
                                Text('Delete', style: AppTheme.bodyMediumGreyStyle),
                              ],
                            ),
                          ),
                          // PopupMenuItem(
                          //   value: 'send rsvp',
                          //   child: Row(
                          //     children: [
                          //       Image.asset(AppIcons.alarm, height: 20, width: 20, color: AppTheme.darkGreyColor),
                          //       const SizedBox(width: 10),
                          //       Text('Send RSVP', style: AppTheme.bodyMediumGreyStyle),
                          //     ],
                          //   ),
                          // ),
                        ],
                        onSelected: onMenuSelected,
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingOnly(top: 40, left: 16),
          ),
          SizedBox(height: 50),
          Text(title ?? "Noraiz XI", style: AppTheme.mediumHeadingFont600Style),
          showSubtitle == false
              ? Container()
              : Text(subTitle ?? "Manchester,London,UK", style: AppTheme.bodyExtraSmallWeight400Style),
          showBody == true
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(body ?? "Manchester,London,UK", style: AppTheme.bodyExtraSmallStyle),
                  Image.asset(AppIcons.dot),
                  Text(type ?? " Cricket", style: AppTheme.bodyExtraSmallStyle.copyWith(color: AppTheme.secondaryColor)),

                ],
              )
              :Container(),

        ],
      ),
    );
  }
}

