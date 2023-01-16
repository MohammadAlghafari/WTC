import 'package:flutter/material.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/login/controller/reset_password_controller.dart';
import 'package:wtc/ui/screens/login/login_screen.dart';
import 'package:wtc/ui/screens/profile/controller/change_password_controller.dart';
import 'package:wtc/ui/shared/customAppTextfield.dart';
import 'package:wtc/ui/shared/custom_appbar.dart';
import 'package:wtc/ui/shared/image_background.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = "/resetPasswordScreen";

  ResetPasswordScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ResetPasswordController resetPasswordController =
      Get.find<ResetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disposeKeyboard();
      },
      child: Scaffold(
        body: ImageBackground(
          child: Column(
            children: [
              CustomAppBar(
                actionButtonType: ActionButtonType.done,
                actionButtonClick: () {
                  disposeKeyboard();

                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    resetPasswordController.changePassword();
                  }
                },
              ),
              Form(
                key: formKey,
                child: Expanded(
                  child: ListView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: getHeight(15),
                      ),
                      Text(
                        "reset_password".tr,
                        style: TextStyle(
                            fontSize: getWidth(34),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      CustomAppTextField(
                        textFieldType: TextFieldType.newPassword,
                        textInputAction: TextInputAction.next,
                        textEditingController:
                            resetPasswordController.newPassword,
                      ),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      CustomAppTextField(
                        textFieldType: TextFieldType.confirmNewPassword,
                        validator: (val) => val!.trim().isNotEmpty
                            ? resetPasswordController.newPassword.text.trim() ==
                                    resetPasswordController
                                        .confirmNewPassword.text
                                        .trim()
                                ? null
                                : "password_mismatch".tr
                            : "please_enter_password".tr,
                        textEditingController:
                            resetPasswordController.confirmNewPassword,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          image: AppBackgrounds.splashBG,
        ),
      ),
    );
  }
}
