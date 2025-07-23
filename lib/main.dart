import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:racrally/routes/app_pages.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:sizer/sizer.dart';
import 'controllers/lazy_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseApp app = Firebase.app();
  final FirebaseOptions options = app.options;
  print("Firebase Project Number: ${options.appId}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            initialRoute: AppRoutes.splash,
            getPages: AppPages.pages,
              initialBinding: LazyController(),
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!,
                  
                );
              },
            // theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
              // home: SplashScreen()
          );
        }
    );
  }
}

