import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_theme/app_theme.dart';
import 'package:racrally/constants/app_icons.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import 'package:racrally/views/team/controller/team_controller.dart';
import 'package:sizer/sizer.dart';
import '../../app_widgets/custom_button.dart';
import '../../utils/custom_dialog.dart';
import '../season/widgets/custom_toggle_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TeamController teamController=Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    teamController.getMyInvites();
    teamController.toggleTab(0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        children: [

          SizedBox(
            height: 8.h,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Get.back();},
                        child: Image.asset(AppIcons.arrow_back_sharp,width: 20,)),
                    Text("Pending Requests",style: AppTheme.mediumHeadingStyle,),
                    Container(width: 50,)
                  ],
                ).paddingOnly(left: 16,right: 16),
                const SizedBox().setHeight(20),
              ],
            ),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.darkGreyColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),

            ),
            child: Obx(() => CustomToggleBar(
              cardWidth: 42.w,
              items: ["Team Invitations", "Event Invitations"],
              selectedIndex: teamController.selectedToggleIndex.value,
              onTap: teamController.toggleTab,
            )).paddingSymmetric(horizontal: 5),
          ).paddingSymmetric(horizontal: 16),
          Obx(
            ()=>teamController.selectedToggleIndex.value==0? SizedBox(
              height: 70.h,
              child:teamController.isLoading.value?
              const Center(child: CircularProgressIndicator(color: AppTheme.secondaryColor)):
              teamController.myTeamInvitesList.isNotEmpty
                  ? ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: teamController.myTeamInvitesList.length,
                itemBuilder: (context, index) {
                  final invite = teamController.myTeamInvitesList[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: AppTheme.darkGreyColor,
                                  ),
                                ),
                                height: 25,
                                width: 25,
                                child: Image.asset(AppIcons.user_place_holder),
                              ).paddingAll(5),
                              const SizedBox().setWidth(5),
                              Text(
                                "${invite.user.firstName} ${invite.user.lastName}",
                                style: AppTheme.bodyMediumStyle,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  CustomDialog.showDeleteDialog(
                                    showSubtitle: true,
                                    subtitle: invite.team.name.toString(),
                                    showIcon: false,
                                    title: "Reject",
                                    description: "Are you sure you want to reject this invite?",
                                    confirmText: "Yes",
                                    onConfirm: () {
                                      teamController.changeInviteStatus(
                                        "rejected",
                                        invite.id.toString(),
                                        false,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppTheme.red.withOpacity(.1),
                                  ),
                                  child: const Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: Color(0xFFEC4F47),
                                  ),
                                ),
                              ),
                              const SizedBox().setWidth(5),
                              GestureDetector(
                                onTap: () {
                                  CustomDialog.showDeleteDialog(
                                    showSubtitle: true,
                                    subtitle: invite.team.name.toString(),
                                    buttonColor: AppTheme.green,
                                    borderColor: AppTheme.green,
                                    showIcon: false,
                                    title: "Accept",
                                    description: "Are you sure you want to accept this invite?",
                                    confirmText: "Yes",
                                    onConfirm: () {
                                      teamController.changeInviteStatus(
                                        "accepted",
                                        invite.id.toString(),
                                        true,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppTheme.primaryCardColor.withOpacity(.1),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Color(0xFF16B364),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ).paddingOnly(left: 16, right: 16),
                      Divider(
                        color: AppTheme.textfieldBorderColor.withOpacity(.3),
                      ),
                    ],
                  );
                },
              ) :Center(child: Text("No Invite Requests",style: AppTheme.mediumLightHeadingWeight600Style,)),
            ): SizedBox(
              height: 70.h,
              child:
              teamController.isLoading.value?
              const Center(child: CircularProgressIndicator(color: AppTheme.secondaryColor)):
              teamController.myEventInvitesList.isNotEmpty
                  ? ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: teamController.myEventInvitesList.length,
                itemBuilder: (context, index) {
                  final invite = teamController.myEventInvitesList[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${invite.user.firstName} ${invite.user.lastName}",
                                style: AppTheme.bodyMediumStyle,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  CustomDialog.showDeleteDialog(
                                    subTitleHeading: "Event Name: ",
                                    showSubtitle: true,
                                    subtitle: invite.event.name.toString(),
                                    showIcon: false,
                                    title: "Reject",
                                    description:
                                    "Are you sure you want to reject this invite?",
                                    confirmText: "Yes",
                                    onConfirm: () {
                                      teamController.changeInviteStatus(
                                        "rejected",
                                        invite.id.toString(),
                                        false,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppTheme.red.withOpacity(.1),
                                  ),
                                  child: const Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: Color(0xFFEC4F47),
                                  ),
                                ),
                              ),
                              const SizedBox().setWidth(5),
                              GestureDetector(
                                onTap: () {
                                  CustomDialog.showDeleteDialog(
                                    subTitleHeading: "Event Name: ",
                                    showSubtitle: true,
                                    subtitle: invite.event.name.toString(),
                                    buttonColor: AppTheme.green,
                                    borderColor: AppTheme.green,
                                    showIcon: false,
                                    title: "Accept",
                                    description:
                                    "Are you sure you want to accept this invite?",
                                    confirmText: "Yes",
                                    onConfirm: () {
                                      teamController.changeInviteStatus(
                                        "accepted",
                                        invite.id.toString(),
                                        true,
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppTheme.primaryCardColor.withOpacity(.1),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Color(0xFF16B364),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).paddingOnly(left: 16, right: 16),
                      Divider(
                        color: AppTheme.textfieldBorderColor.withOpacity(.3),
                      ),
                    ],
                  );
                },
              )
                  : Center(
                child: Text(
                  "No Invite Requests",
                  style: AppTheme.mediumLightHeadingWeight600Style,
                ),
              ),

            ),
          ),

          CustomButton(
            height: 8.h,
            onTap: () {

            },
            Text: "",
            borderColor: AppTheme.textfieldBorderColor.withOpacity(.3),
            buttonColor: AppTheme.primaryColor,
            textColor: AppTheme.darkBackgroundColor,
            isAuth: true,
            isGoogle: false,
            isOnBoarding: true,
            onBoardingText: const Text("Clear All"),
          ).paddingOnly(left: 16,right: 16,bottom: 20)
        ],
      ).paddingOnly(top: 30),
    );
  }
}
