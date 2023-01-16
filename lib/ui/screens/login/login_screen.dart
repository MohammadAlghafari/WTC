import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_color.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/login/controller/login_controller.dart';
import 'package:wtc/ui/screens/login/widget/forgot_password_screen.dart';
import 'package:wtc/ui/screens/register/register_screen.dart';
import 'package:wtc/ui/shared/customAppTextfield.dart';
import 'package:wtc/ui/shared/custombutton.dart';
import 'package:wtc/ui/shared/image_background.dart';

import 'widget/loginButtonsPortion.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);
  static const String routeName = "/loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.find<LoginController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disposeKeyboard();
      },
      child: Scaffold(
        body: ImageBackground(
          image: AppBackgrounds.splashBG,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                bottom: false,
                child: Container(
                  height: 80,
                  // color: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white12),
                          child: const Icon(Icons.arrow_back_sharp),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "login_to_my_account".tr,
                        style: TextStyle(
                            fontSize: getWidth(34),
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomAppTextField(
                        textFieldType: TextFieldType.emailType,
                        textEditingController: loginController.emailText,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomAppTextField(
                        textFieldType: TextFieldType.passwordType,
                        textEditingController: loginController.passwordText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(ForgotPasswordScreen.routeName);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          color: Colors.transparent,
                          child: Text(
                            "forgot_password".tr,
                            style: TextStyle(
                                color: AppColor.kPrimaryBlue,
                                fontSize: getWidth(14)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                          type: CustomButtonType.colourButton,
                          padding: kDefaultPadding,
                          text: "login".tr,
                          onTap: () {
                            disposeKeyboard();

                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              loginController.userLogin();
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      // CustomButton(
                      //     type: CustomButtonType.borderButton,
                      //     padding: kDefaultPadding,
                      //     text: "register_an_account".tr,
                      //     onTap: () {
                      //       disposeKeyboard();
                      //
                      //       Get.toNamed(RegisterScreen.routeName);
                      //     }),
                      SizedBox(
                        height: 60,
                        child: Center(
                          child: Text(
                            "or_sign_in_with".tr,
                            style: TextStyle(
                                color: const Color(0xffABABAB),
                                fontSize: getWidth(17)),
                          ),
                        ),
                      ),
                      LoginButtonsPortion(),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          type: CustomButtonType.borderButton,
                          padding: kDefaultPadding,
                          text: "register_an_account".tr,
                          onTap: () {
                            disposeKeyboard();

                            Get.toNamed(RegisterScreen.routeName);
                          }),
                      const SafeArea(
                        top: false,
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
