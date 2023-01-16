import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_color.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/service/api_routes.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/profile/controller/edit_profile_controller.dart';
import 'package:wtc/ui/screens/profile/widget/change_password.dart';
import 'package:wtc/ui/shared/customAppTextfield.dart';
import 'package:wtc/ui/shared/custombutton.dart';
import 'package:wtc/ui/shared/imagePicker.dart';
import 'package:wtc/ui/shared/image_background.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = "/editProfileScreen";
  final EditProfileController editProfileController =
      Get.find<EditProfileController>();
  EditProfileScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disposeKeyboard();
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ImageBackground(
            image: AppBackgrounds.splashBG,
            child: Column(
              children: [
                const SafeArea(
                  bottom: false,
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                appBar(),
                Expanded(
                  child: ListView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 10),
                      userPicture(),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            disposeKeyboard();
                            appImagePicker.openBottomSheet();
                          },
                          child: Text(
                            "change_photo".tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColor.kPrimaryBlue),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomAppTextField(
                              textFieldType: TextFieldType.firstName,
                              textInputAction: TextInputAction.next,
                              textEditingController:
                                  editProfileController.firstName,
                            ),
                          ),
                          SizedBox(
                            width: getWidth(15),
                          ),
                          Expanded(
                            child: CustomAppTextField(
                              textFieldType: TextFieldType.lastName,
                              textInputAction: TextInputAction.next,
                              textEditingController:
                                  editProfileController.lastName,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      CustomAppTextField(
                        textFieldType: TextFieldType.emailType,
                        textInputAction: TextInputAction.next,
                        textEditingController: editProfileController.email,
                      ),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      CustomAppTextField(
                        textFieldType: TextFieldType.userName,
                        textEditingController: editProfileController.userName,
                      ),
                      Divider(
                        height: getHeight(40),
                        color: Colors.grey,
                      ),
                      changePassword(),
                      SizedBox(
                        height: getHeight(100),
                      ),
                      CustomButton(
                        type: CustomButtonType.colourButton,
                        text: "save_changes".tr,
                        onTap: () {
                          disposeKeyboard();
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            editProfileController.updateProfile();
                          }
                        },
                      ),
                      SafeArea(
                        top: false,
                        child: SizedBox(
                          height: getHeight(25),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector changePassword() {
    return GestureDetector(
      onTap: () {
        appImagePicker.imagePickerController.reset();
        Get.toNamed(ChangePasswordScreen.routeName);
      },
      child: Container(
        color: Colors.transparent,
        child: Text(
          "change_password".tr,
          style: TextStyle(
              color: AppColor.kPrimaryBlue,
              fontSize: getWidth(14),
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  userPicture() {
    return GetBuilder(
      builder: (EditProfileController editProfileController) => GetBuilder(
        builder: (ImagePickerController controller) => Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.transparent,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    onTap: () {
                      disposeKeyboard();
                      appImagePicker.openBottomSheet();
                    },
                    child: Container(
                      height: getWidth(150),
                      width: getWidth(150),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: editProfileController.profileImage == ""
                                ? controller.image == null
                                    ? const AssetImage(
                                        AppIcons.userImagePlaceHolder)
                                    : FileImage(controller.image as File)
                                        as ImageProvider
                                : controller.image == null
                                    ? NetworkImage(imageUrl +
                                        editProfileController.profileImage)
                                    : FileImage(controller.image as File)
                                        as ImageProvider,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -7,
                  right: -7,
                  child: editProfileController.profileImage != "" &&
                          controller.image == null
                      ? removePicture()
                      : editProfileController.profileImage == "" &&
                              controller.image != null
                          ? removePicture()
                          : const SizedBox(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector removePicture() {
    return GestureDetector(
      onTap: () {
        if (appImagePicker.imagePickerController.image != null) {
          appImagePicker.imagePickerController.reset();
        } else {
          editProfileController.profileImage = "";
        }
        editProfileController.update();
      },
      child: Container(
        height: 28,
        width: 28,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, gradient: AppColor.customButtonGradient),
        child: const Center(child: Icon(Icons.close)),
      ),
    );
  }

  Padding appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding)
          .copyWith(bottom: 10),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              child: Text(
                "cancel".tr,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: getWidth(18)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "edit_profile".tr,
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: getWidth(18)),
            ),
          ),
        ],
      ),
    );
  }
}
