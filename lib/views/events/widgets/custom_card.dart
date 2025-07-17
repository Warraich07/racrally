import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';

class CustomCard extends StatelessWidget {
  final bool? isUpComing;
  final String title;
  final String dateTime;
  final String location;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;

  const CustomCard({
    super.key,
    this.isUpComing = true,
    required this.title,
    required this.dateTime,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTheme.bodyMediumFont600Style),
                      const SizedBox().setHeight(1),
                      Text(dateTime, style: AppTheme.bodyExtraSmallFontWeight500Style),
                      const SizedBox().setHeight(1),
                      Text(
                        location,
                        style: AppTheme.bodyExtraSmallStyle.copyWith(
                          color: AppTheme.darkBackgroundColor,
                        ),
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
                       icon: Icon(Icons.more_vert),
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
              width: isUpComing == true ? 77 : 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: isUpComing == true
                    ? AppTheme.lightGreen
                    : AppTheme.lightRed,
              ),
              child: Center(
                child: Text(
                  isUpComing == true ? "Upcoming" : "Past",
                  style: AppTheme.bodyExtraSmallFontTenStyle.copyWith(
                    color: isUpComing == true ? AppTheme.green : AppTheme.red,
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
