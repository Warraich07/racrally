import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';

class CustomCardAttendees extends StatelessWidget {
  final bool? isAttending;
  final String name;
  final String details;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;

  const CustomCardAttendees({
    super.key,
    this.isAttending,
    required this.name,
    required this.details,
    this.onEditTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 64,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: AppTheme.textfieldBorderColor.withOpacity(0.3),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Info
                 Row(
                   children: [
                     Image.asset(AppIcons.userIcon,height: 35,),
                     SizedBox().setWidth(5),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(name, style: AppTheme.bodyMediumFont600Style),
                         const SizedBox().setHeight(1),
                         Text(
                           details,
                           style: AppTheme.bodyExtraSmallWeight400Style,
                         ),
                       ],
                     ),
                   ],
                 ),

                  // Popup menu
                  PopupMenuButton<String>(
                    color: AppTheme.primaryColor,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'remove',
                        child: Row(
                          children: [
                            Image.asset(AppIcons.delete, height: 20, width: 20),
                            const SizedBox(width: 10),
                            Text('Remove', style: AppTheme.bodyMediumGreyStyle),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'sendInvite',
                        child: Row(
                          children: [
                            // Image.asset(AppIcons.delete, height: 20, width: 20),
                            Icon(Icons.share,color: AppTheme.textfieldBorderColor,),
                            const SizedBox(width: 10),
                            Text('Send Invite', style: AppTheme.bodyMediumGreyStyle),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'remove') {
                        onEditTap?.call();
                      } else if (value == 'sendInvite') {
                        onDeleteTap?.call();
                      }
                    },
                  ),
                ],
              ),
            ],
          ).paddingOnly(left: 16),

          // Upcoming/Past Label
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 18,
              width: isAttending == true ? 80 :isAttending == false ?100: 85,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: isAttending == true
                    ? AppTheme.lightGreen
                    :  isAttending == false?AppTheme.lightRed:AppTheme.lightGreyColor.withOpacity(.1),
              ),
              child: Center(
                child: Text(
                  isAttending == true ? "ATTENDING" :isAttending == false ? "NOT ATTENDING":"NO RESPONSE",
                  style: AppTheme.bodyExtraSmallFontTenStyle.copyWith(
                    color: isAttending == true ? AppTheme.green :isAttending == false ? AppTheme.red:AppTheme.darkGreyColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
