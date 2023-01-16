import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/login/controller/login_controller.dart';
import 'package:wtc/ui/screens/login/model/loginButtonProps.dart';
import 'package:wtc/ui/screens/login/widget/accept_privacy_policy_dialog.dart';
import 'package:wtc/ui/shared/custombutton.dart';

class LoginButtonsPortion extends StatelessWidget {
  LoginButtonsPortion({Key? key}) : super(key: key);
  final List<LoginButtonProp> loginButtonList = [
    LoginButtonProp(name: "sign_in_with_google".tr, image: AppIcons.google),
    LoginButtonProp(name: "sign_in_with_facebook".tr, image: AppIcons.facebook),
    LoginButtonProp(name: "sign_in_with_apple".tr, image: AppIcons.apple),
  ];
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: loginButtonList
          .asMap()
          .map((key, value) => MapEntry(
              key,
              key == 2
                  ? Platform.isIOS
                      ? view(context, value, key)
                      : const SizedBox()
                  : view(context, value, key)))
          .values
          .toList(),
    );
  }

  Widget view(
      BuildContext context, LoginButtonProp loginButtonProp, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: CustomButton(
          type: CustomButtonType.borderButton,
          padding: kDefaultPadding,
          customizableChild: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(loginButtonProp.image, height: 25),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(loginButtonProp.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getWidth(17),
                      fontWeight: FontWeight.w500,
                    )),
              )
            ],
          ),
          onTap: () {
            disposeKeyboard();
            if (index == 0) {
              showAcceptPrivacyPolicyDialog(
                  context: context,
                  signInFunction: () {
                    loginController.socialLogin(SocialLoginProvider.google);
                  });
            } else if (index == 1) {
              showAcceptPrivacyPolicyDialog(
                  context: context,
                  signInFunction: () {
                    loginController.socialLogin(SocialLoginProvider.facebook);
                  });
            } else if (index == 2) {
              loginController.socialLogin(SocialLoginProvider.apple);
            }
          }),
    );
  }
}
