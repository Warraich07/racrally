import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/constants/app_images.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';

class CustomTeamCard extends StatelessWidget {
  final bool? isActive;
  final String title;
  final String teamCode;
  final String location;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;

  const CustomTeamCard({
    super.key,
    this.isActive = true,
    required this.title,
    required this.teamCode,
    required this.location,
    this.onEditTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 84,
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
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppTheme.darkBackgroundColor
                        ),
                        child: Image.asset(AppImages.basketball).paddingAll(5),
                      ),
                      const SizedBox().setWidth(10),
                      // Image.asset("name"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: AppTheme.bodyMediumFont600Style),
                          const SizedBox().setHeight(1),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 18, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: "Team Code",
                                    style: AppTheme.bodyExtraSmallFontWeight500Style
                                ),
                                TextSpan(
                                  text: teamCode,
                                  style:  AppTheme.bodyMediumFont600Style.copyWith(color: AppTheme.secondaryColor),
                                ),

                              ],
                            ),
                          ),

                          // Text(teamCode, style: AppTheme.bodyExtraSmallFontWeight500Style),
                          const SizedBox().setHeight(1),
                          Text(
                            location,
                            style: AppTheme.bodyExtraSmallStyle.copyWith(
                              color: AppTheme.darkBackgroundColor,
                            ),
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
                          value: 'edit',
                          child: Row(
                            children: [
                              Image.asset(AppIcons.edit, height: 20, width: 20),
                              const SizedBox(width: 10),
                              Text('Edit', style: AppTheme.bodyMediumGreyStyle),
                            ],
                          ),
                        ),
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
                      ],
                      onSelected: (value) {
                        if (value == 'edit') {
                          onEditTap?.call();
                        } else if (value == 'delete') {
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
              width: isActive == true ? 60 : 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: isActive == true
                    ? AppTheme.lightGreen
                    : AppTheme.lightRed,
              ),
              child: Center(
                child: Text(
                  isActive == true ? "Active" : "InActive",
                  style: AppTheme.bodyExtraSmallFontTenStyle.copyWith(
                    color: isActive == true ? AppTheme.green : AppTheme.red,
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
