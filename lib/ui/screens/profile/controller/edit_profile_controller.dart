import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/core/utils/shared_prefrences.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/login/model/wtc_user_model.dart';

class EditProfileController extends GetxController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController userName = TextEditingController();
  String profileImage = "";
  Future updateProfile() async {
    if (profileImage == "" &&
        appImagePicker.imagePickerController.image == null) {
      await removePicture();
    }
    final response = await UserRepo.updateProfile(
        userName: userName.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        picture: appImagePicker.imagePickerController.image);
    if (response != null) {
      flutterToast(response["success"]["message"]);
      LocalDB.saveUserDetails(WtcUserModel.fromJson(response));
      Get.back();
    }
  }

  Future removePicture() async {
    final response = await UserRepo.removePicture();
    if (response != null) {
      profileImage = "";
      userController.wtcUserModel.success.profileImg = "";
      update();
    }
  }

  @override
  void onInit() {
    email.text = userController.wtcUserModel.success.email;
    firstName.text = userController.wtcUserModel.success.firstname;
    lastName.text = userController.wtcUserModel.success.lastname;
    userName.text = userController.wtcUserModel.success.username;
    profileImage = userController.profileImage;

    super.onInit();
  }

  @override
  void onClose() {
    appImagePicker.imagePickerController.image = null;
    super.onClose();
  }
}
