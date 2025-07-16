import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/constants/app_icons.dart';
import 'package:racrally/constants/app_images.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:racrally/routes/app_pages.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:racrally/views/auth/controller/auth_controller.dart';
import 'package:racrally/views/home/widgets/custom_event_card.dart';
import 'package:racrally/views/home/widgets/custom_team_card.dart';
import 'package:sizer/sizer.dart';

import '../../app_theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Color> cardColors=[
    Color(0xFF16B364),
    Color(0xFFEC4F47),
    Color(0xFFEF6820),
    Color(0xFFEAAA08),
  ];
  List<String> cardTexts=[
    'Total Players',
    'Games This Week',
    'Bill Splitted',
    'Events This Week'
  ];
  List<String> cardAnalysis=[
    '46',
    '12',
    '\$3.5K',
    '40'
  ];
  int _currentIndex = 0;
  AuthController authController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        children: [
          Container(
            height:Platform.isIOS?30.h: 42.h,
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              image: DecorationImage(
                image: AssetImage(AppImages.topbar_ellipses,), // replace with your image path
                alignment: Alignment.topRight,
                fit: BoxFit.none,
                scale: 4.7
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap:(){
                          Get.toNamed(AppRoutes.profile);
                              },
                        child: Image.asset(AppIcons.userIcon,height: 40,)),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome 👋",style: AppTheme.bodyMediumStyle.copyWith(fontWeight: FontWeight.w600,color: AppTheme.primaryColor),),
                        Text(authController.userData.value!.firstName.capitalizeFirst!+" "+authController.userData.value!.lastName,style: AppTheme.bodyMediumGreyStyle.copyWith(color: AppTheme.primaryColor),)
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.notifications);
                        },
                        child: Image.asset(AppIcons.notification,height: 24,))
                  ],
                ),
                const SizedBox().setHeight(20),
                CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (context, index, realIndex) {
                    return const CustomTeamCard();
                  },
                  options: CarouselOptions(
                    height: 100,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    autoPlay: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(

                      5, (index) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? AppTheme.darkPrimaryColor
                            : AppTheme.primaryColor,
                      ),
                    );
                  }),
                ),
              ],
            ).paddingOnly(left: 16,right: 16,top:Platform.isIOS?60: 40,bottom: 20),
          ),
          Container(
            // color: Colors.yellow,
            height:Platform.isIOS?57.h: 45.h,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    padding: EdgeInsets.only(top: 20),
                    shrinkWrap: true,
                    itemCount: 4,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.8,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 40.w,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: AppTheme.textfieldBorderColor.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cardTexts[index],style: AppTheme.bodyExtraSmallStyle,).paddingSymmetric(horizontal: 10),
                            Text(cardAnalysis[index],style: AppTheme.subHeadingStyle,).paddingSymmetric(horizontal: 10),
                            Spacer(),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: cardColors[index].withOpacity(.1),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight:  Radius.circular(8))
                              ),
                              child: Text("Includes subs & coaches",style: AppTheme.bodyExtraSmallFontTenStyle.copyWith(color: cardColors[index]),).paddingSymmetric(horizontal: 10,vertical: 2),
                            )

                          ],
                        ).paddingOnly(top: 7),
                      );
                    },
                  ),
                  SizedBox().setHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Upcoming Events",style: AppTheme.mediumHeadingStyle,),
                      Text("See All",style: AppTheme.bodyMediumFont600Style.copyWith(color: AppTheme.secondaryColor),),
                    ],
                  ),
                  SizedBox().setHeight(10),
                 CustomEventCard()
                ],
              ).paddingSymmetric(horizontal: 16),
            ),
          )
        ],
      ),
    );
  }
}
