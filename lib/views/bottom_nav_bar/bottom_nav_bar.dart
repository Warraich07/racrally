import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:sizer/sizer.dart';
import '../../app_theme/app_theme.dart';
import '../../constants/app_icons.dart';
import '../events/event_screen.dart';
import '../home/home_screen.dart';
import '../team/team_screen.dart';
import 'controller/bottom_bar_controller.dart';

class CustomBottomBarr extends StatefulWidget {
  const CustomBottomBarr({super.key});

  @override
  State<CustomBottomBarr> createState() => _CustomBottomBarrState();
}

class _CustomBottomBarrState extends State<CustomBottomBarr> {
  final GeneralController _generalController = Get.put(GeneralController());

  final List<Widget> pages = [
    const HomeScreen(),
    const TeamScreen(),
    const EventScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        if (_generalController.currentIndex == 0) {
          // Exit dialog or action here
        } else {
          _generalController.onBottomBarTapped(0);
        }
      },
      child: Obx(
            () => Scaffold(
              backgroundColor: AppTheme.primaryColor,

              body: pages[_generalController.currentIndex],
          bottomNavigationBar: _buildBottomBar(),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(

      height: 13.h,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppTheme.textfieldBorderColor.withOpacity(.3),
            width: 2,
          ),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _generalController.currentIndex,
        onTap: (index) {
          _generalController.onBottomBarTapped(index);
        },
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        showUnselectedLabels: true,
        selectedItemColor: AppTheme.secondaryColor,
        unselectedItemColor: Colors.black.withOpacity(0.6),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          color: AppTheme.secondaryColor,
          fontFamily: 'medium',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          color: AppTheme.darkBackgroundColor,
          fontFamily: 'medium',
        ),
        items: [
          BottomNavigationBarItem(
            icon: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _generalController.currentIndex == 0? Image.asset(AppIcons.halfEllipses,width: 15,height: 10,):SizedBox(height: 10,width: 15,),
                  SizedBox().setHeight(2),
                  Image.asset(
                    _generalController.currentIndex == 0
                        ?  AppIcons.bottomBarOne
                        : AppIcons.bottomBarOne,
                    height: 22,
                    width: 22,
                    color: _generalController.currentIndex == 0
                        ? AppTheme.secondaryColor
                        : AppTheme.darkBackgroundColor,
                  ),
                  SizedBox().setHeight(3),
                ],
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _generalController.currentIndex == 1? Image.asset(AppIcons.halfEllipses,width: 15,height: 10,):SizedBox(height: 10,width: 15,),
                  SizedBox().setHeight(2),
                  Image.asset(
                    _generalController.currentIndex == 1
                        ? AppIcons.bottomBarTwo
                        : AppIcons.bottomBarTwo,
                    height: 22,
                    width: 22,
                    color: _generalController.currentIndex == 1
                        ? AppTheme.secondaryColor
                        : AppTheme.darkBackgroundColor,
                  ),
                  SizedBox().setHeight(3),
                ],
              ),
            ),
            label: "Teams",
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _generalController.currentIndex == 2? Image.asset(AppIcons.halfEllipses,width: 15,height: 10,):SizedBox(height: 10,width: 15,),
                  SizedBox().setHeight(2),
                  Image.asset(
                    _generalController.currentIndex == 2
                        ? AppIcons.bottomBarThree
                        : AppIcons.bottomBarThree,
                    height: 22,
                    width: 22,
                    color: _generalController.currentIndex == 2
                        ? AppTheme.secondaryColor
                        : AppTheme.darkBackgroundColor,
                  ),
                  SizedBox().setHeight(3),
                ],
              ),
            ),
            label: "Events",
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _generalController.currentIndex == 3? Image.asset(AppIcons.halfEllipses,width: 15,height: 10,):SizedBox(height: 10,width: 15,),
                  SizedBox().setHeight(2),
                  Image.asset(
                    _generalController.currentIndex == 3
                        ? AppIcons.bottomBarFour
                        : AppIcons.bottomBarFour,
                    height: 22,
                    width: 22,
                    color: _generalController.currentIndex == 3
                        ? AppTheme.secondaryColor
                        : AppTheme.darkBackgroundColor,
                  ),
                  SizedBox().setHeight(3),
                ],
              ),
            ),
            label: "Seasons",
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _generalController.currentIndex == 4? Image.asset(AppIcons.halfEllipses,width: 15,height: 10,):SizedBox(height: 10,width: 15,),
                  SizedBox().setHeight(2),
                  Image.asset(
                    _generalController.currentIndex == 4
                        ? AppIcons.bottomBarFive
                        : AppIcons.bottomBarFive,
                    height: 22,
                    width: 22,
                    color: _generalController.currentIndex == 4
                        ? AppTheme.secondaryColor
                        : AppTheme.darkBackgroundColor,
                  ),
                  SizedBox().setHeight(3),

                ],
              ),
            ),
            label: "Chat",
          ),
        ],
      ),
    );
  }
}
