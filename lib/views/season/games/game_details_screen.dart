import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/views/season/controller/season_controller.dart';
import 'package:racrally/views/season/widgets/custom_toggle_bar.dart';
import 'package:sizer/sizer.dart';
import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';
import '../widgets/custom_game_card.dart';


class GameDetailsScreen extends StatefulWidget {
  const GameDetailsScreen({super.key});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  final SeasonController seasonController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        children: [
          SizedBox().setHeight(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(AppIcons.arrow_back_sharp,width: 20,),
              Text("Games",style: AppTheme.mediumHeadingStyle,),
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
                      // onEditTap?.call();
                    } else if (value == 'delete') {
                      // onDeleteTap?.call();
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox().setHeight(5),
          CustomGameCard(),
          SizedBox().setHeight(20),
          Container(
            height: 40,
            decoration: BoxDecoration(
                color: AppTheme.darkGreyColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),

            ),
            child: Obx(() => CustomToggleBar(
              items: ["Active Players", "Reserves", "Who’s IN"],
              selectedIndex: seasonController.selectedToggleIndex.value,
              onTap: seasonController.toggleTab,
            )).paddingSymmetric(horizontal: 5),
          ),

        ],
      ).paddingSymmetric(horizontal: 16,vertical: 16),
    );
  }
}
