import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:racrally/views/season/widgets/custom_game_card.dart';
import '../../../app_theme/app_theme.dart';
import '../../../app_widgets/custom_button.dart';
import '../../../constants/app_icons.dart';

class CreateGameScreen extends StatelessWidget {
  const CreateGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        children: [
          const SizedBox().setHeight(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(AppIcons.arrow_back_sharp,width: 20,),
              Text("Games",style: AppTheme.mediumHeadingStyle,),
              Container(width: 30,)
            ],
          ),
          const SizedBox().setHeight(10),
          GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.gameDetails);
              },
              child: const CustomGameCard()),
          const Spacer(),
          const CustomButton(Text: "Create New Game")
        ],
      ).paddingSymmetric(horizontal: 16,vertical: 16),
    );
  }
}
