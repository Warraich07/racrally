import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:racrally/views/auth/forget_password_screen.dart';
import 'package:racrally/views/auth/login_screen.dart';
import 'package:racrally/views/auth/reset_password_screen.dart';
import 'package:racrally/views/auth/verify_otp_screen.dart';
import 'package:racrally/views/events/event_details_screen.dart';
import 'package:racrally/views/home/notifications.dart';
import 'package:racrally/views/intro/splash_screen.dart';
import 'package:racrally/views/profile/profile_screen.dart';
import 'package:racrally/views/season/games/create_game_screen.dart';
import 'package:racrally/views/season/games/game_details_screen.dart';
import 'package:racrally/views/season/season_details_screen.dart';
import 'package:racrally/views/team/player_details_screen.dart';
import '../views/auth/sign_up_screen.dart';
import '../views/bottom_nav_bar/bottom_nav_bar.dart';
import '../views/intro/onboarding_screen.dart';
import '../views/team/team_details_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () =>  SplashScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.signUp, page: () => const SignUpScreen()),
    GetPage(name: AppRoutes.onboarding, page: () =>  OnboardingScreen()),
    GetPage(name: AppRoutes.forgetPassword, page: () =>  ForgetPasswordScreen()),
    GetPage(name: AppRoutes.verifyOtp, page: () =>  VerifyOtpScreen()),
    GetPage(name: AppRoutes.bottomBar, page: () =>  CustomBottomBarr()),
    GetPage(name: AppRoutes.resetPassword, page: () =>  const ResetPasswordScreen()),
    GetPage(name: AppRoutes.notifications, page: () =>  const NotificationScreen()),
    GetPage(name: AppRoutes.eventDetail, page: () =>   EventDetailsScreen()),
    GetPage(name: AppRoutes.playerDetails, page: () =>  const PlayerDetailsScreen()),
    GetPage(name: AppRoutes.profile, page: () =>  const ProfileScreen()),
    GetPage(name: AppRoutes.seasonDetails, page: () =>  const SeasonDetailsScreen()),
    GetPage(name: AppRoutes.createGame, page: () =>  const CreateGameScreen()),
    GetPage(name: AppRoutes.gameDetails, page: () =>  const GameDetailsScreen()),

  ];
}
