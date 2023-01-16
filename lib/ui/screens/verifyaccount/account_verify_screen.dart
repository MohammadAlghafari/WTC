import 'package:flutter/material.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/login/login_screen.dart';
import 'package:wtc/ui/shared/custombutton.dart';
import 'package:wtc/ui/shared/image_background.dart';
import 'package:get/get.dart';

class AccountVerifyScreen extends StatefulWidget {
  const AccountVerifyScreen({Key? key}) : super(key: key);
  static const String routeName = "/accountVerifyScreen";

  @override
  _AccountVerifyScreenState createState() => _AccountVerifyScreenState();
}

class _AccountVerifyScreenState extends State<AccountVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: ImageBackground(
          image: AppBackgrounds.splashBG2,
          child: Column(
            children: [
              const Spacer(
                flex: 3,
              ),
              Image.asset(
                AppIcons.smileLogo,
                height: 100,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "verify_your_account".tr,
                style: TextStyle(
                    fontSize: getWidth(34), fontWeight: FontWeight.w500),
              ),
              Text(
                "check_your_email".tr,
                style: TextStyle(
                  fontSize: getWidth(16),
                  color: const Color(0xffABABAB),
                ),
              ),
              SizedBox(
                height: getHeight(50),
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
      ),
    );
  }
}
