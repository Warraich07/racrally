import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/constants/app_images.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/extensions/width_extension.dart';
import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';

class CustomSeasonCard extends StatelessWidget {
  final bool? isCurrent;
  final String title;
  final String imagePath;
  final String dateTime;
  final String location;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;

  const CustomSeasonCard({
    super.key,
    this.isCurrent = true,
    required this.title,
    required this.imagePath,
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
                Row(
                  children: [
                    Container(
                        child: Image.asset(imagePath,height: 50,width: 50,)),
                    SizedBox().setWidth(5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTheme.bodyMediumFont700Style),
                        const SizedBox().setHeight(1),
                        Text(dateTime, style: AppTheme.bodyExtraSmallStyle.copyWith(color:AppTheme.darkBackgroundColor )),
                        const SizedBox().setHeight(1),
                        Text(
                          location,
                          style: AppTheme.bodyExtraSmallStyle.copyWith(
                            color: AppTheme.darkGreyColor,
                          ),
                        ),
                      ],
                    ),


                  ],
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
          ).paddingOnly(left: 10),

          // Upcoming/Past Label
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 18,
              width: isCurrent == true ? 120 :isCurrent == false ?100: 135,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: isCurrent == true
                    ? AppTheme.lightGreyColor.withOpacity(.1)
                    :  isCurrent == false?AppTheme.lightRed:AppTheme.lightGreen,
              ),
              child: Center(
                child: Text(
                  isCurrent == true ? "CURRENT SEASON" :isCurrent == false ? "PAST SEASON":"SEASON COMPLETED",
                  style: AppTheme.bodyExtraSmallFontTenStyle.copyWith(
                    color: isCurrent == true ? AppTheme.darkGreyColor :isCurrent == false ? AppTheme.red:AppTheme.green,
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
