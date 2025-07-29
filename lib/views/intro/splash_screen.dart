import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/app_theme/app_theme.dart';
import 'package:racrally/constants/app_icons.dart';
import 'package:racrally/extensions/height_extension.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.maintainSessionAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppTheme.secondaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Image.asset(AppIcons.splash, height: 80, width: 80),
                Column(
                  children: [
                    Text(
                      "Organize your team, the easy way",
                      style: AppTheme.bodySmallStyle,
                    ),
                    const SizedBox().setHeight(10),
                    Obx(() => LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10),
                      value: controller.progress.value,
                      minHeight: 10,
                      backgroundColor: Colors.white,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.darkPrimaryColor),
                    )),
                    Platform.isIOS?const SizedBox().setHeight(40):const SizedBox()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
