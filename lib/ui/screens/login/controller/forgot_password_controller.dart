import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/core/utils/app_function.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController email = TextEditingController();
  Future forgotPassword() async {
    var response = await UserRepo.forgotPasswordRepo(email: email.text.trim());
    if (response != null) {
      flutterToast(response["success"]["message"]);
      Get.back();
    }
  }
}
