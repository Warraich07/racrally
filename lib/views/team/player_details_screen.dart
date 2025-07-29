import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import 'package:sizer/sizer.dart';
import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_header.dart';
import '../../constants/app_icons.dart';
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
    final Map<String, dynamic> data = Get.arguments;
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              CustomHeader(
                showPopUpMenu: false,
                showBackArrow: true,
                title: data['name'],
                subTitle:  data['type'],
                onMenuSelected: (value) {
                  if (value == 'edit') {
                    print(teamController.teamList[0].name);
                    print(teamController.teamList[0].location);
                    print(teamController.teamList[0].image);
                    // CreateTeamSheet.show(context, true,teamController.teamList[0].name,teamController.teamList[0].location,teamController.teamList[0].image,teamController.teamList[0].color);
                    print("Edit selected");
                  } else if (value == 'delete') {
                    print("Delete selected");
                  }
                  // else if (value == 'send rsvp') {
                  //   CustomDialog.showReminderDialog(iconPath: AppIcons.share);
                  // }
                },
              ),


              Column(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:AppTheme.primaryLittleDarkColor.withOpacity(.7),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),

                        child:Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(AppIcons.email,height: 20,width: 20,),
                                const SizedBox().setWidth(5),
                                Text(data['email'],style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.darkBackgroundColor),),

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
                  const SizedBox().setHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Seasons Played",style: AppTheme.mediumLightHeadingWeight600Style,),

                    ],
                  ),
                  const SizedBox().setHeight(10),

                  SizedBox(
                    height: 45.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text("No Seasons Played",style: AppTheme.bodyExtraSmallWeight600Style,),)
                        // CustomSeasonCard(imagePath: AppImages.basketball,title: "Major Cricket League", dateTime: "27 Jun 2025 - 27 Jul 2025", location: "Lahore, Punjab, PK",isCurrent:true,showPopUpMenu: false,),
                        // CustomSeasonCard(imagePath: AppImages.basketball,title: "Major Cricket League", dateTime: "27 Jun 2025 - 27 Jul 2025", location: "Lahore, Punjab, PK",isCurrent:false,showPopUpMenu: false,),
                        // CustomSeasonCard(imagePath: AppImages.basketball,title: "Major Cricket League", dateTime: "27 Jun 2025 - 27 Jul 2025", location: "Lahore, Punjab, PK",isCurrent:null,showPopUpMenu: false,),
                      ],
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
                    padding: const EdgeInsets.all(3),
                  height: 100,
                  width: 100,
                    decoration: BoxDecoration(
                        color: AppTheme.primaryDarkColor,
                        shape: BoxShape.circle,
                        border: Border.all(width: 1,color: AppTheme.darkGreyColor)
                    ),
                  child: Image.asset(AppIcons.user_place_holder)
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}



