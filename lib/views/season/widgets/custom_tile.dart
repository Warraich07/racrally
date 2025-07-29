import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';

class CustomTilePlayer extends StatelessWidget {
  const CustomTilePlayer(
      {super.key,this.status,this.imagePath,this.title,this.suffixIcon,this.isInvite,this.showStatus});
  final String? status;
  final String? imagePath;
  final String? title;
  final Widget? suffixIcon;
  final bool? isInvite;
  final bool? showStatus;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
            height: 1,
            color: AppTheme.textfieldBorderColor.withOpacity(0.3)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
    showStatus!=null||showStatus!=true?Image.asset(status??AppIcons.accepted,height: 16,width: 16,).paddingOnly(right: 5):Container(),
                Image.asset(imagePath??AppIcons.userIcon,height: 22,width: 22,).paddingOnly(right: 5),
                Text(title??"Phoenix Baker",style: AppTheme.bodyExtraSmallStyle,),],
            ),
            Row(
              children: [
                isInvite!=null?
                Text("Invite",
                  style: AppTheme.bodyExtraSmallWeight600Style.copyWith(
                      color: AppTheme.secondaryColor),):
                Container(),
                Theme(
                  data: Theme.of(context).copyWith(
                    popupMenuTheme: PopupMenuThemeData(
                      iconSize: 25,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: SizedBox(
                    height: 40,
                    child:suffixIcon?? PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
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
                      ],
                      onSelected: (value) {
                        if (value == 'edit') {
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).paddingOnly(left: 10)

      ],
    );
  }
}
