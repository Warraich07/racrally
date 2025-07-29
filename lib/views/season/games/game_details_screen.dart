import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/views/season/controller/season_controller.dart';
import 'package:racrally/views/season/widgets/custom_toggle_bar.dart';
import '../../../app_theme/app_theme.dart';
import '../../../constants/app_icons.dart';
import '../widgets/custom_game_card.dart';
import '../widgets/custom_tile.dart';


class GameDetailsScreen extends StatefulWidget {
  const GameDetailsScreen({super.key});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  final SeasonController seasonController=Get.find();
  List<String> statuses=[
    AppIcons.accepted,
    AppIcons.cancelled,
    AppIcons.pending,
  ];
  List<bool> statusesList=[
    false,
    true,
    true

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox().setHeight(40),
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
            const SizedBox().setHeight(5),
            const CustomGameCard(),
            const SizedBox().setHeight(20),
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
            const SizedBox().setHeight(15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1,
                  color: AppTheme.textfieldBorderColor.withOpacity(0.3)
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                  ()=> Text(seasonController.selectedToggleIndex.value==0?
                  "Active Players (23)":seasonController.selectedToggleIndex.value==1?"Reserves (23)":"In Game",
                          style: AppTheme.bodyMediumFont600Style,),
                      ),
                      Obx(
                        ()=>seasonController.selectedToggleIndex.value==0||seasonController.selectedToggleIndex.value==1? Row(
                          children: [
                            Text(
                              "Yes: 12  ",
                              style: AppTheme.bodyExtraSmallWeight600Style.copyWith(color: AppTheme.primaryCardColor),
                            ),
                            Container(
                              height: 18,width: 2,
                              color: AppTheme.dividerColor,
                            ).paddingOnly(left: 3,right: 6),
                            Text(
                              "NO: 4  ",
                              style:  AppTheme.bodyExtraSmallWeight600Style.copyWith(color: AppTheme.red),
                            ),
                            Container(
                              height: 18,width: 2,
                              color: AppTheme.dividerColor,
                            ).paddingOnly(left: 3,right: 6),
                            Text(
                              "NR: 5",
                              style:  AppTheme.bodyExtraSmallWeight600Style.copyWith(color: AppTheme.darkGreyColor),
                            ),
                          ],
                        ):Container(),
                      )
                    ],
                  ).paddingOnly(left: 10,right: 10,top: 10,bottom: 10),
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: statuses.length,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                    return Obx(
                        ()=>seasonController.selectedToggleIndex.value==0? 
                        CustomTilePlayer(
                          showStatus: true,
                          status: statuses[index],
                        ):
                        seasonController.selectedToggleIndex.value==1?
                        CustomTilePlayer(isInvite:true,showStatus: statusesList[index],):
                        CustomTilePlayer(suffixIcon: Image.asset(AppIcons.dots_grid),),
                    );
                  })
                ],
              ),
            )
        
          ],
        ).paddingSymmetric(horizontal: 16,vertical: 16),
      ),
    );
  }
}
