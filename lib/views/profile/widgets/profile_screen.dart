import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';

import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';

class CustomTile extends StatefulWidget {
  const CustomTile({super.key,this.title,this.isNotificationTile});
  final String? title;
  final bool? isNotificationTile;

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {

    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title??'',style: AppTheme.bodySmallGreyStyle,),
           widget.isNotificationTile==true? SizedBox(
             height: 25,
             child: Switch(
             value: isSwitched,
             onChanged: (value) {
             setState(() {
             isSwitched = value;
             });
             },
             activeColor: AppTheme.primaryColor,
             activeTrackColor: AppTheme.secondaryColor,
             inactiveThumbColor: AppTheme.primaryColor,
             inactiveTrackColor: AppTheme.lightGreyColor,
             ),
           ): Image.asset(AppIcons.arrow_forward,height: 15,),
          ],
        ),
        const SizedBox().setHeight(5),
        Divider(
          color: AppTheme.textfieldBorderColor.withOpacity(0.3),
        )
      ],
    ).paddingOnly(left: 16,right: 16,top: 10);
  }
}
