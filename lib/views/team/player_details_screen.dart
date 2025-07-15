import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_widgets/custom_season_card.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import 'package:racrally/views/team/widgets/invite_player_sheet.dart';
import 'package:sizer/sizer.dart';

import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_button.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_images.dart';
import '../../utils/custom_dialog.dart';
import '../events/widgets/custom_card_attendees.dart';
import 'controller/team_controller.dart';

class PlayerDetailsScreen extends StatefulWidget {
  const PlayerDetailsScreen({super.key});

  @override
  State<PlayerDetailsScreen> createState() => _PlayerDetailsScreenState();
}

class _PlayerDetailsScreenState extends State<PlayerDetailsScreen> {
  TeamController teamController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Image.asset(AppIcons.arrow_back_sharp,width: 20,)),
                        Theme(
                          data: Theme.of(context).copyWith(
                            popupMenuTheme: PopupMenuThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: PopupMenuButton<String>(
                            color: AppTheme.primaryColor,
                            itemBuilder: (context) => [
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
                              PopupMenuItem(
                                value: 'send rsvp',
                                child: Row(
                                  children: [
                                    Image.asset(AppIcons.alarm, height: 20, width: 20,color: AppTheme.darkGreyColor,),
                                    const SizedBox(width: 10),
                                    Text('Send RSVP', style: AppTheme.bodyMediumGreyStyle),
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (value) {
                              if (value == 'edit') {
                                // onEditTap?.call();
                              } else if (value == 'delete') {
                                // onDeleteTap?.call();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ).paddingOnly(top: 40, left: 16),
              ),
              SizedBox(height: 50), // space for the overlapping image
              Text("Noraiz XI",style: AppTheme.mediumHeadingFont600Style,),
              Text("Manchester,London,UK",style: AppTheme.bodyExtraSmallWeight400Style,),

              Column(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:AppTheme.primaryLittleDarkColor.withOpacity(.7),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),

                        child:Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(AppIcons.email,height: 20,width: 20,),
                                SizedBox().setWidth(5),
                                Text("noraiz12@gmail.com",style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),),

                              ],
                            ),

                          ],
                        ).paddingAll(16),
                      ),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color:  AppTheme.textfieldBorderColor.withOpacity(0.3),
                      )
                    ],
                  ),
                  SizedBox().setHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Seasons Played",style: AppTheme.mediumLightHeadingWeight600Style,),

                    ],
                  ),
                  SizedBox().setHeight(10),

                  SizedBox(
                    height: 45.h,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomSeasonCard(imagePath: AppImages.basketball,title: "Major Cricket League", dateTime: "27 Jun 2025 - 27 Jul 2025", location: "Lahore, Punjab, PK",isCurrent:true),
                          CustomSeasonCard(imagePath: AppImages.basketball,title: "Major Cricket League", dateTime: "27 Jun 2025 - 27 Jul 2025", location: "Lahore, Punjab, PK",isCurrent:false),
                          CustomSeasonCard(imagePath: AppImages.basketball,title: "Major Cricket League", dateTime: "27 Jun 2025 - 27 Jul 2025", location: "Lahore, Punjab, PK",isCurrent:null),
                        ],
                      ),
                    ),
                  ),
                ],
              ).paddingOnly(left: 16,right: 16,top: 10)

            ],
          ),

          /// Positioned Image (half inside, half outside the top container)
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
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AppIcons.userIcon, // use your image path
                      fit: BoxFit.cover,
                    ),
                  )
                ),

              ],
            ),
          ),
        ],
      )
    );
  }
}



