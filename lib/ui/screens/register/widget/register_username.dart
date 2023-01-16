import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/login/login_screen.dart';
import 'package:wtc/ui/screens/register/controller/register_controller.dart';
import 'package:wtc/ui/shared/customAppTextfield.dart';
import 'package:wtc/ui/shared/custom_appbar.dart';
import 'package:wtc/ui/shared/custombutton.dart';
import 'package:wtc/ui/shared/image_background.dart';

class RegisterUserNameScreen extends StatefulWidget {
  const RegisterUserNameScreen({
    Key? key,
  }) : super(key: key);
  static const String routeName = "/registerUserNameScreen";

  @override
  State<RegisterUserNameScreen> createState() => _RegisterUserNameScreenState();
}

class _RegisterUserNameScreenState extends State<RegisterUserNameScreen> {
  RegisterController registerController = Get.find<RegisterController>();
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
              const CustomAppBar(
                actionButtonType: ActionButtonType.textButton,
                pageNum: "2",
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
                        "your_username".tr,
                        style: TextStyle(
                            fontSize: getWidth(34),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "set_your_username".tr,
                        style: TextStyle(
                          fontSize: getWidth(16),
                          color: const Color(0xffABABAB),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      CustomAppTextField(
                        textFieldType: TextFieldType.userName,
                        textEditingController: registerController.userNameText,
                      ),
                      SizedBox(
                        height: getHeight(50),
                      ),
                      CustomButton(
                          type: CustomButtonType.colourButton,
                          padding: kDefaultPadding,
                          text: "next".tr,
                          onTap: () {
                            disposeKeyboard();

                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              registerController.userRegister();
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
