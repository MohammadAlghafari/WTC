import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/core/utils/app_function.dart';

class ChangePasswordController extends GetxController {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  Future changePassword() async {
    var response = await UserRepo.changePassword(
        currentPassword: currentPassword.text.trim(),
        newPassword: newPassword.text.trim());
    if (response != null) {
      flutterToast(response["success"]["message"]);
      Get.back();
    }
  }
}
