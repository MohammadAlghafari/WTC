import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/ui/screens/login/login_screen.dart';
import 'package:wtc/ui/screens/login/model/reset_password_datamodel.dart';

class ResetPasswordController extends GetxController {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  Future changePassword() async {
    var response = await UserRepo.resetPassword(
        newPassword: newPassword.text.trim(),
        email: resetPasswordDataModel.email,
        token: resetPasswordDataModel.token);
    if (response != null) {
      flutterToast(response["success"]["message"]);
      Get.offAllNamed(LoginScreen.routeName);
    }
  }

  late ResetPasswordDataModel resetPasswordDataModel;
  @override
  void onInit() {
    resetPasswordDataModel = Get.arguments;
    super.onInit();
  }
}
