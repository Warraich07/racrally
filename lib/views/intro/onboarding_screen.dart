import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_theme/app_theme.dart';
import 'package:racrally/constants/app_images.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'package:sizer/sizer.dart';
import '../../app_widgets/custom_button.dart';
import '../../routes/app_routes.dart';
import '../../services/local_storage/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    OnboardingPage(
      image: AppImages.onBoardingOne, // Add this image to your assets folder
      title: 'Easily Organize Your\nRecreational Team',
      subtitle: 'Plan your games, notify players, and manage\nattendance all from one simple dashboard',
    ),
    OnboardingPage(
      image: AppImages.onBoardingTwo,
      title: 'Track Payments, Sponsors\n& Lineups Easily',
      subtitle: 'Handle team fees, sponsorships, and game\nlineups without the messy group texts',
    ),
    OnboardingPage(
      image: AppImages.onBoardingThree,
      title: 'Know Who’s In Before\nGame Day',
      subtitle: 'Players can RSVP with one tap so you’re never\n caught short on game day again',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE9ECFF), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: ()async {
                    await AuthPreference.instance.setFirstTime(false);
                    Get.offAndToNamed(AppRoutes.login);
                  },
                  child: Text('Skip',style: AppTheme.bodyMediumStyle,),
                ),
              ),
              SizedBox(height: Platform.isIOS?60:0),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => _pages[index],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                      (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? AppTheme.secondaryColor : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              const SizedBox().setHeight(12.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: _currentIndex == 0
                    ? Center(
                  child: CustomButton(
                    onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    Text: 'Next',
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 30.w,
                      child: CustomButton(
                            onTap: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                        Text: "",
                        borderColor: AppTheme.textfieldBorderColor.withOpacity(.3),
                        buttonColor: AppTheme.primaryColor,
                        textColor: AppTheme.darkBackgroundColor,
                        isAuth: true,
                        isGoogle: false,
                        isOnBoarding: true,
                        onBoardingText: Text("Previous"),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                      child: CustomButton(
                        onTap: ()async {
                          if (_currentIndex < _pages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          } else {
                            print("object");
                            await AuthPreference.instance.setFirstTime(false);
                            Get.offAndToNamed(AppRoutes.login);
                            // Finish onboarding
                          }
                        },
                        Text: 'Next',
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image on top of the gradient
        Image.asset(
          image,
          height: MediaQuery.of(context).size.height * 0.35,
          fit: BoxFit.contain,
        ),

        // Text + spacing + scrollable content
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    title,
                    style: AppTheme.subHeadingStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8), // Reduced from 12
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    subtitle,
                    style: AppTheme.bodyExtraSmallStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


