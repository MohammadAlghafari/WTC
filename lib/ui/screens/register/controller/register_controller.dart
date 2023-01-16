import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/guest/guest_screen.dart';

import 'package:wtc/ui/screens/verifyaccount/account_verify_screen.dart';

class RegisterController extends GetxController {
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController userNameText = TextEditingController();
  Future userRegister() async {
    var response = await UserRepo.userRegisterRepo(
      email: emailText.text.trim(),
      userName: userNameText.text.trim(),
      password: passwordText.text.trim(),
    );
    if (response != null) {
      flutterToast(response["success"]["message"]);
      if (userController.guestLoginFlow) {
        Get.offNamedUntil(AccountVerifyScreen.routeName,
            (route) => route.settings.name == GuestScreen.routeName);
      } else {
        Get.offAllNamed(AccountVerifyScreen.routeName);
      }
    }
  }
}
