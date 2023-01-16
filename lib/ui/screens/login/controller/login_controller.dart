import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wtc/core/service/auth/appleAuth.dart';
import 'package:wtc/core/service/auth/fbAuth.dart';
import 'package:wtc/core/service/auth/googleAuth.dart';
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/core/utils/keyChain.dart';
import 'package:wtc/core/utils/shared_prefrences.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/camera/get_started_screen.dart';
import 'package:wtc/ui/screens/login/model/wtc_user_model.dart';
import 'package:wtc/ui/screens/onboarding/onboarding_screen.dart';
import 'package:wtc/ui/screens/photo_preview/controller/car_found_controller.dart';

class LoginController extends GetxController {
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  Future userLogin() async {
    var response = await UserRepo.userLoginRepo(
      email: emailText.text.trim(),
      password: passwordText.text.trim(),
    );
    if (response != null) {
      LocalDB.saveUserDetails(WtcUserModel.fromJson(response));
      navigationFlow();
    }
  }

  Future socialLogin(SocialLoginProvider socialLoginProvider) async {
    String? name;
    String? email;
    String? socialId;
    if (SocialLoginProvider.google == socialLoginProvider) {
      await GoogleAuth.signInWithGoogle().then((value) {
        print("AMISHA $value");
        if (value != null) {
          name = value.displayName;
          email = value.email;
          socialId = value.id;
        }
      });
    } else if (SocialLoginProvider.facebook == socialLoginProvider) {
      await FBAuth.fbLogin().then((value) {
        if (value != null) {
          name = value["name"];
          email = value["email"];
          socialId = value["id"];
        }
      });
    } else if (SocialLoginProvider.apple == socialLoginProvider) {
      await AppleAuth.appleLogin().then((credential) async {
        final cred = await getKeyChain();
        if (cred == null) {
          putKeyChain(name: credential.givenName, email: credential.email);
        }
        name = credential.givenName ?? cred!["name"];
        email = credential.email ?? cred!["email"];
        socialId = credential.userIdentifier ?? cred!["userIdentifier"];
      });
    }
    if (name != null &&(email != null || socialId!= null)) {
      final response = await UserRepo.socialLoginRepo(
          username: name!,
          email: email ?? "",
          socialId: socialId!,
          socialLoginProvider: socialLoginProvider);
      if (response != null) {
        LocalDB.saveUserDetails(WtcUserModel.fromJson(response));
        navigationFlow();
      }
    }
  }

  void navigationFlow() async {
    if (LocalDB.onBoardingRead()) {
      if (userController.guestLoginFlow) {
        if (userController.guestAsFlow) {
          if (userController.saveHistory) {
            await Get.find<CarFoundController>()
                .saveToHistory(showLoader: true);
          }
          Get.back();
          Get.back();
        } else {
          Get.offAllNamed(GetStartedScreen.routeName);
        }
      } else {
        Get.offAllNamed(GetStartedScreen.routeName);
      }
    } else {
      if (userController.guestLoginFlow) {
        if (userController.guestAsFlow) {
          if (userController.saveHistory) {
            await Get.find<CarFoundController>()
                .saveToHistory(showLoader: true);
          }
          // Get.offNamedUntil(OnBoardingScreen.routeName,
          //     (route) => route.settings.name == GuestScreen.routeName);
          Get.offNamed(OnBoardingScreen.routeName);
        } else {
          Get.offAllNamed(GetStartedScreen.routeName);
        }
      } else {
        Get.offAllNamed(OnBoardingScreen.routeName);
      }
    }
  }
}
