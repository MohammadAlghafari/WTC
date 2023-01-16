import 'package:flutter/material.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/guest/guest_screen.dart';
import 'package:wtc/ui/screens/login/login_screen.dart';
import 'package:wtc/ui/shared/custombutton.dart';
import 'package:wtc/ui/shared/double_tap_to_back.dart';
import 'package:wtc/ui/shared/image_background.dart';
import 'package:get/get.dart';

class VerificationCompleteScreen extends StatelessWidget {
  static const String routeName = "/verificationCompleteScreen";

  const VerificationCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userController.guestLoginFlow) {
      return WillPopScope(
          child: buildScaffold(), onWillPop: () => Future.value(false));
    } else {
      return DoubleBackToCloseApp(
        child: buildScaffold(),
      );
    }
  }

  Scaffold buildScaffold() {
    return Scaffold(
      body: ImageBackground(
        image: AppBackgrounds.splashBG,
        child: Column(
          children: [
            const Spacer(
              flex: 3,
            ),
            Image.asset(
              AppIcons.doneCheck,
              height: 100,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "you_are_verified".tr,
              style: TextStyle(
                  fontSize: getWidth(34), fontWeight: FontWeight.w500),
            ),
            Text(
              "click_the_link".tr,
              style: TextStyle(
                fontSize: getWidth(16),
                color: const Color(0xffABABAB),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
                type: CustomButtonType.colourButton,
                padding: kDefaultPadding,
                width: getWidth(156),
                text: "login_now".tr,
                onTap: () {
                  Get.offNamed(LoginScreen.routeName);
                }),
            const Spacer(
              flex: 1,
            ),
            Center(
              child: Image.asset(
                AppIcons.landScapeWTFLogo,
                height: 40,
              ),
            ),
            SizedBox(
              height: getHeight(15),
            ),
            Center(
              child: Text(
                "copyright".tr,
                style: TextStyle(
                  fontSize: getWidth(10),
                  color: const Color(0xffBBBBBB),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: SizedBox(
                height: getHeight(30),
              ),
            )
          ],
        ),
      ),
    );
  }
}
