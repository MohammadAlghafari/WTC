import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/camera/controller/get_started_controller.dart';
import 'package:wtc/ui/screens/camera/get_started_screen.dart';
import 'package:wtc/ui/screens/login/login_screen.dart';
import 'package:wtc/ui/screens/register/register_screen.dart';
import 'package:wtc/ui/shared/custombutton.dart';
import 'package:wtc/ui/shared/image_background.dart';

class LandingScreen extends StatelessWidget {
  static const String routeName = "/landingScreen";

  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ImageBackground(
      image: AppBackgrounds.splashBG2,
      child: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Image.asset(
            AppIcons.landingScreenLogo,
            height: getHeight(380),
          ),
          const Spacer(),
          CustomButton(
              type: CustomButtonType.colourButton,
              padding: kDefaultPadding * 2,
              text: "scan_now".tr,
              onTap: () async {
                Get.offAllNamed(GetStartedScreen.routeName);
              }),
          SizedBox(
            height: getHeight(15),
          ),
          CustomButton(
              type: CustomButtonType.borderButton,
              padding: kDefaultPadding * 2,
              text: "login_to_my_account".tr,
              onTap: () {
                Get.toNamed(LoginScreen.routeName);
              }),
          SizedBox(
            height: getHeight(25),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "don't_have".tr,
                style: TextStyle(fontSize: getWidth(16)),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RegisterScreen.routeName);
                },
                child: Text(
                  "register".tr,
                  style: TextStyle(
                      fontSize: getWidth(16), color: const Color(0xff017DF5)),
                ),
              )
            ],
          ),
          const Spacer()
        ],
      ),
    ));
  }
}
