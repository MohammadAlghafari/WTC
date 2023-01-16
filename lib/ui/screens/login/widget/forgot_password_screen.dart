import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/login/controller/forgot_password_controller.dart';
import 'package:wtc/ui/shared/customAppTextfield.dart';
import 'package:wtc/ui/shared/custombutton.dart';
import 'package:wtc/ui/shared/image_background.dart';

import '../login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  static const String routeName = "/forgotPasswordScreen";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ForgotPasswordController forgotPasswordController =
      Get.find<ForgotPasswordController>();
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    children: [
                      SizedBox(
                        height: getHeight(15),
                      ),
                      Text(
                        "forgot_password".tr,
                        style: TextStyle(
                            fontSize: getWidth(34),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      CustomAppTextField(
                        textFieldType: TextFieldType.emailType,
                        textEditingController: forgotPasswordController.email,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                      CustomButton(
                          type: CustomButtonType.colourButton,
                          padding: kDefaultPadding,
                          text: "send".tr,
                          onTap: () {
                            disposeKeyboard();

                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              forgotPasswordController.forgotPassword();
                            }
                          }),
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
