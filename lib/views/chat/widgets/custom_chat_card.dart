import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';

class CustomChatCard extends StatelessWidget {
  final String name;
  final String subTitle;
  final String details;
  final VoidCallback? onTapSend;
  final VoidCallback? onDeleteTap;
  final bool isTeam;

  const CustomChatCard({
    super.key,
    required this.isTeam,
    required this.subTitle,
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
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1,color: AppTheme.darkGreyColor)
                          ),
                          height: 30,
                          width: 30,
                          child: Image.asset(AppIcons.user_place_holder)).paddingAll(5),
                      const SizedBox().setWidth(5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: AppTheme.bodyMediumFont600Style),
                          const SizedBox().setHeight(1),
                          isTeam?Row(
                            children: [
                              Text(
                                subTitle,
                                style: AppTheme.bodyExtraSmallWeight400Style.copyWith(color: AppTheme.darkBackgroundColor),
                              ),
                              Text(
                                details,
                                style: AppTheme.bodyExtraSmallWeight400Style,
                              )
                            ],
                          ):Text(
                            details,
                            style: AppTheme.bodyExtraSmallWeight400Style,
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Popup menu
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.green
                        ),
                        child: Center(child: Text('1',style: AppTheme.bodyExtraSmallFontTenStyle,)),
                      ),
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

                            // PopupMenuItem(
                            //   value:isTeamScreen==true?'sendInvite': 'sendInvite',
                            //   child: Row(
                            //     children: [
                            //       Image.asset(AppIcons.share, height: 20, width: 20,color: AppTheme.textfieldBorderColor),
                            //
                            //       const SizedBox(width: 10),
                            //       Text(isTeamScreen==true?'Resend Invite':'Send Invite', style: AppTheme.bodyMediumGreyStyle),
                            //     ],
                            //   ),
                            // ),
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
                              onDeleteTap?.call();
                            } else if (value == 'sendInvite') {
                              onTapSend?.call();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ).paddingOnly(left: 12),


        ],
      ),
    );
  }
}
