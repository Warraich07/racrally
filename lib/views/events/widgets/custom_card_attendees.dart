import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';

class CustomCardAttendees extends StatelessWidget {
  final bool? isAttending;
  final bool? isTeamScreen;
  final String name;
  final String details;
  final VoidCallback? onTapSend;
  final VoidCallback? onDeleteTap;

  const CustomCardAttendees({
    super.key,
    this.isAttending,
    this.isTeamScreen,
    required this.name,
    required this.details,
    this.onTapSend,
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
                     Container(
                         padding: EdgeInsets.all(3),
                         decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             border: Border.all(width: 1,color: AppTheme.darkGreyColor)
                         ),
                         height: 30,
                         width: 30,
                         child: Image.asset(AppIcons.user_place_holder)).paddingAll(5),
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
                          value:isTeamScreen==true?'sendInvite': 'sendInvite',
                          child: Row(
                            children: [
                              Image.asset(AppIcons.share, height: 20, width: 20,color: AppTheme.textfieldBorderColor),

                              const SizedBox(width: 10),
                              Text(isTeamScreen==true?'Resend Invite':'Send Invite', style: AppTheme.bodyMediumGreyStyle),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'remove',
                          child: Row(
                            children: [
                              Image.asset(AppIcons.delete, height: 20, width: 20,color: AppTheme.textfieldBorderColor),
                              const SizedBox(width: 10),
                              Text('Remove', style: AppTheme.bodyMediumGreyStyle),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'remove') {
                          onTapSend?.call();
                        } else if (value == 'sendInvite') {
                          onDeleteTap?.call();
                        }
                      },
                    ),
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
                  isAttending == true ? "JOINING" :isAttending == false ? "NO RESPONSE":"NOT JOINING",
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
