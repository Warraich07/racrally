import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:racrally/app_widgets/custom_button.dart';
import 'package:racrally/constants/app_images.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:racrally/views/team/controller/team_controller.dart';
import 'package:racrally/views/team/widgets/create_team_sheet.dart';
import 'package:racrally/views/team/widgets/custom_team_card.dart';
import 'package:racrally/views/team/widgets/invite_player_sheet.dart';
import 'package:sizer/sizer.dart';
import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_header.dart';
import '../../app_widgets/custom_text_field.dart';
import '../../constants/app_icons.dart';
import '../../utils/custom_dialog.dart';
import '../events/widgets/create_event_bottom_sheet.dart';
import '../events/widgets/custom_card_attendees.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}
class _TeamScreenState extends State<TeamScreen> {
  TeamController teamController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    teamController.getTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: teamController.isTeamCreated.value==false?
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Team Management",style: AppTheme.mediumHeadingStyle,),
                // Image.asset(AppIcons.event,height: 24,width: 24,)
              ],
            ).paddingOnly(top: Platform.isIOS?30:0),
            SizedBox().setHeight(10),

            Spacer(flex: 1,),
            Image.asset(AppImages.teamMembers,width: 35.w,),
            Text("You haven’t created a team yet",style: AppTheme.mediumLightHeadingWeight600Style,),
            Center(child: Text(
              "Start by building your team and inviting players",
              textAlign: TextAlign.center,
              style: AppTheme.bodyExtraSmallWeight400Style,)),
            SizedBox().setHeight(10),
            CustomButton(
              height: 40,
              width: 42.w,
              iconPath: AppIcons.addIcon,
              onTap: (){
                CreateTeamSheet.show(context,false,'name','location','image','color','1');
              },
              Text: "Create Team",
              borderColor: AppTheme.secondaryColor,
              buttonColor: AppTheme.secondaryColor,
              textColor: AppTheme.primaryColor,
              isAuth: true,
              isGoogle: false,
            ),
            Spacer(flex: 2,),


          ],
        ).paddingOnly(left: 16,right: 16,top: 40):
        Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                CustomHeader(
                  title: teamController.teamList[0].name,
                  subTitle: teamController.teamList[0].location,
                  onMenuSelected: (value) {
                    if (value == 'edit') {
                      print(teamController.teamList[0].name);
                      print(teamController.teamList[0].location);
                      print(teamController.teamList[0].image);
                      CreateTeamSheet.show(context, true,teamController.teamList[0].name,teamController.teamList[0].location,teamController.teamList[0].image,teamController.teamList[0].color,teamController.teamList[0].id.toString());
                      print("Edit selected");
                    } else if (value == 'delete') {
                      CustomDialog.showDeleteDialog(
                          title: "Delete Team",
                          description: "This will remove the Team from the system",
                          iconPath: AppIcons.delete,
                        onConfirm: (){
                            // Get.back();
                            teamController.deleteTeam(teamController.teamList[0].id.toString());
                        }
                      );
                      print("Delete selected");
                    }
                    // else if (value == 'send rsvp') {
                    //   CustomDialog.showReminderDialog(iconPath: AppIcons.share);
                    // }
                  },
                ),
                teamController.isPlayerInvited.value==true?
                    SizedBox(
                      height: 51.h,
                      child: Column(
                        children: [
                          CustomButton(
                              onTap: (){
                                InvitePlayerSheet.show(context,teamController.teamList[0].id.toString());
                              },
                              Text: "Invite Member"),
                          SizedBox().setHeight(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Team Members",style: AppTheme.mediumLightHeadingWeight600Style,),
                              Row(
                                children: [
                                  Row(
                                    children: [ Image.asset(AppIcons.accepted,height: 18,width: 18,),const SizedBox().setWidth(3),Text("12",style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
                                  ),
                                  const SizedBox().setWidth(5),
                                  Row(
                                    children: [ Image.asset(AppIcons.cancelled,height: 18,width: 18,),const SizedBox().setWidth(3),Text("05",style: AppTheme.bodyExtraSmallStyle.copyWith( color:AppTheme.darkBackgroundColor),)],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox().setHeight(10),
                         Container(
                           height: 40,
                           decoration: BoxDecoration(
                             color: AppTheme.darkGreyColor.withOpacity(0.1),
                             borderRadius: BorderRadius.circular(8)
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               GestureDetector(
                                 onTap: (){
                                   teamController.toggleRoaster();
                                 },
                                 child: Container(
                                   height: 32,
                                   width: 43.w,
                                   decoration: BoxDecoration(
                                       color:teamController.isActiveRoaster.value==true?AppTheme.extraLightGreyColor: null,
                                       borderRadius: BorderRadius.circular(8)
                                   ),
                                   child: Center(
                                       child: Text(
                                         "Active Roasters",
                                         style: AppTheme.bodyExtraSmallWeight600Style.copyWith(
                                             color:teamController.isActiveRoaster.value==true?AppTheme.darkBackgroundColor: AppTheme.darkGreyColor

                                         ),)),
                                 ),
                               ),
                               GestureDetector(
                                 onTap: (){
                                   teamController.toggleRoaster();
                                 },
                                 child: Container(
                                   height: 32,
                                   width: 43.w,
                                   decoration: BoxDecoration(
                                       color:teamController.isActiveRoaster.value==false?AppTheme.extraLightGreyColor: null,
                                       borderRadius: BorderRadius.circular(8)
                                   ),
                                   child: Center(
                                       child: Text(
                                     "Reserve Players",
                                     style: AppTheme.bodyExtraSmallWeight600Style.copyWith(
                                     color:teamController.isActiveRoaster.value==false?AppTheme.darkBackgroundColor: AppTheme.darkGreyColor

                                   ),)),
                                 ),
                               ),
                             ],
                           ).paddingSymmetric(horizontal: 5),
                         ),
                          SizedBox().setHeight(10),
                          SizedBox(
                            height: 24.h,
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: 0),
                              itemCount:teamController.isActiveRoaster.value==true?teamController.sentInvitesList[0].activeRoster.length:teamController.sentInvitesList[0].reservedPlayers.length,
                              shrinkWrap: true,
                                itemBuilder: (context,index){
                              return teamController.isActiveRoaster.value==true?
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(AppRoutes.playerDetails);
                                },
                                child: CustomCardAttendees(
                                  name: teamController.sentInvitesList[0].activeRoster[index].user.firstName+" "+teamController.sentInvitesList[0].activeRoster[index].user.lastName,
                                  details:teamController.sentInvitesList[0].activeRoster[index].user.email,
                                  isAttending:teamController.sentInvitesList[0].activeRoster[index].status=='pending'?false:true,
                                  isTeamScreen:true,
                                  onTapSend: (){
                                    CustomDialog.showDeleteDialog(
                                        title: "Remove Player",
                                        description: "This will remove the role from the system",
                                        iconPath: AppIcons.delete
                                    );
                                  },),
                              ):
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(AppRoutes.playerDetails);
                                },
                                child: CustomCardAttendees(
                                  name: teamController.sentInvitesList[0].reservedPlayers[index].user.firstName+" "+teamController.sentInvitesList[0].reservedPlayers[index].user.lastName,
                                  details:teamController.sentInvitesList[0].reservedPlayers[index].user.email,
                                  isAttending:teamController.sentInvitesList[0].reservedPlayers[index].status=='pending'?false:true,
                                  isTeamScreen:true,
                                  onTapSend: (){
                                    CustomDialog.showDeleteDialog(
                                        title: "Remove Player",
                                        description: "This will remove the role from the system",
                                        iconPath: AppIcons.delete
                                    );
                                  },),
                              );
                            }),
                          ),
                        ],
                      ).paddingOnly(left: 16,right: 16,top: 10),
                    )
                    :Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Spacer(flex: 1),
                    SizedBox().setHeight(5.h),
                    Image.asset(AppImages.teamMembers, width: 20.w),
                    Text("No team members yet", style: AppTheme.mediumLightHeadingWeight600Style),
                    Center(
                      child: Text(
                        "Start by inviting players to your team. You can\nassign them as Coach, Player, or Sub",
                        textAlign: TextAlign.center,
                        style: AppTheme.bodyExtraSmallWeight400Style,
                      ),
                    ),
                    SizedBox().setHeight(10),
                    CustomButton(
                      textSize: 14,
                      height: 40,
                      width: 45.w,
                      iconPath: AppIcons.teamMember,
                      onTap: () {
                        InvitePlayerSheet.show(context,teamController.teamList[0].id.toString());
                      },
                      Text: "Invite Members",
                      borderColor: AppTheme.secondaryColor,
                      buttonColor: AppTheme.secondaryColor,
                      textColor: AppTheme.primaryColor,
                      isAuth: true,
                      isGoogle: false,
                    ),
                    // Spacer(flex: 3),
                  ],
                )
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
                      color: AppTheme.darkBackgroundColor,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:teamController.teamList[0].image,
                        placeholder: (context, url) =>
                            Center(
                                child: CircularProgressIndicator(
                                  color: AppTheme.secondaryColor,
                                )),
                        errorWidget: (context, url,
                            error) =>
                            Image.asset(
                              AppImages.topbar_ellipses,scale: 5.3,
                            ),
                        fit: BoxFit.cover,
                        // scale:20 ,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        )

      ),
    );
  }
}
