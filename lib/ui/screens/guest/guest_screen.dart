import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/login/login_screen.dart';
import 'package:wtc/ui/screens/register/register_screen.dart';
import 'package:wtc/ui/shared/custom_appbar.dart';
import 'package:wtc/ui/shared/custombutton.dart';

class GuestScreen extends StatelessWidget {
  static const String routeName = "/guestScreen";

  const GuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            leadingButtonShow: false,
            actionButtonClick: () {
              Get.back();
            },
            actionButtonType: ActionButtonType.cancel,
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppIcons.wtcLogo,
                  height: getWidth(80),
                  width: getWidth(80),
                ),
                SizedBox(
                  height: getHeight(50),
                ),
                Text(
                  "hi_guest".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: getWidth(34)),
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                Text(
                  "login_or".tr,
                  style: TextStyle(
                      fontSize: getWidth(16), color: Color(0xffABABAB)),
                ),
                SizedBox(
                  height: getHeight(20),
                ),
                CustomButton(
                    type: CustomButtonType.colourButton,
                    text: "login_to_my".tr,
                    onTap: () {
                      userController.saveHistory = Get.arguments;
                      userController.guestLoginFlow = true;
                      Get.toNamed(LoginScreen.routeName);
                    }),
                SizedBox(
                  height: getHeight(15),
                ),
                CustomButton(
                    type: CustomButtonType.borderButton,
                    text: "register".tr,
                    onTap: () {
                      userController.saveHistory = Get.arguments;

                      userController.guestLoginFlow = true;

                      Get.toNamed(RegisterScreen.routeName);
                    }),
              ],
            ),
          ),
          const Spacer(
            flex: 2,
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
    );
  }
}
