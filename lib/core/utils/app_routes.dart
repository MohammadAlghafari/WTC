import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wtc/ui/screens/camera/get_started_screen.dart';
import 'package:wtc/ui/screens/car_details/car_detail_screen.dart';
import 'package:wtc/ui/screens/guest/guest_screen.dart';
import 'package:wtc/ui/screens/landing/landing_screen.dart';
import 'package:wtc/ui/screens/login/login_screen.dart';
import 'package:wtc/ui/screens/login/widget/forgot_password_screen.dart';
import 'package:wtc/ui/screens/login/widget/reset_password.dart';
import 'package:wtc/ui/screens/notification_screen/notification_screen.dart';
import 'package:wtc/ui/screens/onboarding/onboarding_screen.dart';
import 'package:wtc/ui/screens/photo_preview/widget/car_found_screen.dart';
import 'package:wtc/ui/screens/profile/edit_profile_screen.dart';
import 'package:wtc/ui/screens/profile/widget/change_password.dart';
import 'package:wtc/ui/screens/profile/widget/profile_screen.dart';
import 'package:wtc/ui/screens/recent/recent_screen.dart';
import 'package:wtc/ui/screens/register/register_screen.dart';
import 'package:wtc/ui/screens/register/widget/register_username.dart';
import 'package:wtc/ui/screens/splash/splash_screen.dart';
import 'package:wtc/ui/screens/verifyaccount/account_verify_screen.dart';
import 'package:wtc/ui/screens/verifyaccount/verification_complete_screen.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
  GetPage(name: LandingScreen.routeName, page: () => const LandingScreen()),
  GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
  GetPage(name: RegisterScreen.routeName, page: () => const RegisterScreen()),
  GetPage(
      name: ResetPasswordScreen.routeName, page: () => ResetPasswordScreen()),
  GetPage(
      name: RegisterUserNameScreen.routeName,
      page: () => const RegisterUserNameScreen()),
  GetPage(
      name: AccountVerifyScreen.routeName,
      page: () => const AccountVerifyScreen()),
  GetPage(name: OnBoardingScreen.routeName, page: () => OnBoardingScreen()),
  GetPage(
      name: GetStartedScreen.routeName, page: () => const GetStartedScreen()),
  GetPage(name: CarFoundScreen.routeName, page: () => CarFoundScreen()),
  GetPage(
      name: CarDetailScreen.routeName,
      page: () => CarDetailScreen(
            key: Key(DateTime.now().toString()),
          )),
  GetPage(name: RecentScreen.routeName, page: () => const RecentScreen()),
  GetPage(name: GuestScreen.routeName, page: () => const GuestScreen()),
  GetPage(name: EditProfileScreen.routeName, page: () => EditProfileScreen()),
  GetPage(name: ProfileScreen.routeName, page: () => const ProfileScreen()),
  GetPage(
      name: VerificationCompleteScreen.routeName,
      page: () => const VerificationCompleteScreen()),
  GetPage(
      name: ChangePasswordScreen.routeName, page: () => ChangePasswordScreen()),
  GetPage(
      name: ForgotPasswordScreen.routeName, page: () => ForgotPasswordScreen()),
GetPage(name: NotificationScreen.routeName, page:()=>const NotificationScreen()),
];
