import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:sizer/sizer.dart';

import '../../app_theme/app_theme.dart';
import '../../app_widgets/custom_season_card.dart';
import '../../app_widgets/custom_text_field.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_images.dart';
import '../../routes/app_routes.dart';
import '../../utils/custom_dialog.dart';
import '../events/widgets/custom_card.dart';
import 'widgets/create_season_sheet.dart';

class SeasonScreen extends StatefulWidget {
  const SeasonScreen({super.key});

  @override
  State<SeasonScreen> createState() => _SeasonScreenState();
}

class _SeasonScreenState extends State<SeasonScreen> {

  Timer? _debounce;

  void onSearchChanged(String value) {
    // Cancel previous timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    // Start a new timer
    _debounce = Timer(const Duration(milliseconds: 700), () {
      print("User stopped typing. Final value: $value");
    });
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Clean up
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        floatingActionButton: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FloatingActionButton(
            backgroundColor: AppTheme.secondaryColor,
            onPressed: () {
              CreateSeasonSheet.show(context);
            },
            child: Icon(Icons.add,color: AppTheme.primaryColor,),
          ),
        ),

        backgroundColor: AppTheme.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Season Management",style: AppTheme.mediumHeadingStyle,),
                  Image.asset(AppIcons.event,height: 24,width: 24,)
                ],
              ),
              SizedBox().setHeight(10),
              CustomTextField(
                hintText: "Search here",
                prefixIcon: AppIcons.search,
                prefixIconColor: AppTheme.lightGreyColor,
                onChanged: onSearchChanged,
              ),
              SizedBox().setHeight(15),
              SizedBox(
                height: 45.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap:(){
                              Get.toNamed(AppRoutes.seasonDetails);
                          },
                          child: CustomSeasonCard(

                              imagePath: AppImages.basketball,
                              title: "Major Cricket League",
                              dateTime: "27 Jun 2025 - 27 Jul 2025",
                              location: "Lahore, Punjab, PK",
                              isCurrent:true)),
                      CustomSeasonCard(imagePath: AppImages.basketball,title: "Major Cricket League", dateTime: "27 Jun 2025 - 27 Jul 2025", location: "Lahore, Punjab, PK",isCurrent:false),
                      CustomSeasonCard(imagePath: AppImages.basketball,title: "Major Cricket League", dateTime: "27 Jun 2025 - 27 Jul 2025", location: "Lahore, Punjab, PK",isCurrent:null),
                    ],
                  ),
                ),
              ),

            ],
          ).paddingOnly(left: 16,right: 16,top: 40),
        ),
      ),
    );
  }
}
