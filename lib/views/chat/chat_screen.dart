import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/views/chat/controller/chat_controller.dart';
import 'package:racrally/views/chat/widgets/custom_chat_card.dart';
import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_text_field.dart';
import '../../constants/app_icons.dart';
import '../../utils/custom_dialog.dart';
import '../season/widgets/custom_toggle_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Timer? _debounce;
  ChatController chatController=Get.find();
  void onSearchChanged(String value) {
    // Cancel previous timer
    setState(() {
      // chatController.chatList.clear();
    });
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    // Start a new timer
    _debounce = Timer(const Duration(milliseconds: 0), () {

      if(value.isEmpty){
        // eventController.getEvents();
      }else{
        // eventController.searchEvents(value, "asc", true);
      }

      print("User stopped typing. Final value: $value");
    });
  }
  final focusNodeSearchHere=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Event Management",style: AppTheme.mediumHeadingStyle,),
              Theme(
                data: Theme.of(context).copyWith(
                  popupMenuTheme: PopupMenuThemeData(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: PopupMenuButton<String>(
                  icon: Image.asset(AppIcons.event,height: 24,width: 24,),
                  color: AppTheme.primaryColor,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'A-Z',
                      child: Row(
                        children: [
                          const Icon(Icons.filter_alt_off,color: AppTheme.lightGreyColor,),
                          const SizedBox(width: 10),
                          Text('A-Z', style: AppTheme.bodyMediumGreyStyle),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Z-A',
                      child: Row(
                        children: [
                          const Icon(Icons.filter_alt_off,color: AppTheme.lightGreyColor,),
                          const SizedBox(width: 10),
                          Text('Z-A', style: AppTheme.bodyMediumGreyStyle),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    // focusNodeSearchHere.unfocus();
                    // if (value == 'A-Z') {
                    //   eventController.searchEvents("", "asc", false);
                    //   print("A-Z");
                    // } else if (value == 'Z-A') {
                    //   print("Z-A");
                    //   eventController.searchEvents("", "desc", false);
                    // }
                  },
                ),
              ),
            ],
          ).paddingOnly(left: 16,top:Platform.isIOS?70: 40,right: 5),
          Expanded(
            child: Column(
              children: [
                const SizedBox().setHeight(10),
                CustomTextField(
                  focusNode: focusNodeSearchHere,
                  hintText: "Search here",
                  prefixIcon: AppIcons.search,
                  prefixIconColor: AppTheme.lightGreyColor,
                  onChanged: onSearchChanged,
                ),
                const SizedBox().setHeight(15),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.darkGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Obx(() => CustomToggleBar(
                    items: ["All", "Direct", "Teams"],
                    selectedIndex: chatController.selectedToggleIndex.value,
                    onTap: chatController.toggleTab,
                  )).paddingSymmetric(horizontal: 5),
                ),
                const SizedBox().setHeight(15),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 0),
                      itemCount:2,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        return GestureDetector(
                            onTap: (){
                            },
                            child: CustomChatCard(
                              subTitle: 'Noraiz: ',
                              isTeam:index==0? true:false,
                              onDeleteTap: (){
                                CustomDialog.showDeleteDialog(
                                    title: "Remove Player",
                                    description: "This will remove the role from the system",
                                    iconPath: AppIcons.delete,
                                    onConfirm: (){
                                      // teamController.removeMemberFromTeam(teamController.sentInvitesList[0].activeRoster[index].userId.toString(), teamController.sentInvitesList[0].activeRoster[index].teamId.toString());
                                    }
                                );
                              },
                  
                              name: "talha",
                              details:"talhaadhsj",
                              onTapSend: (){
                              },),
                          );
                      }),
                )
              ],
            ).paddingOnly(left: 16,right: 16),
          )
        ],
      ),
    );
  }
}
