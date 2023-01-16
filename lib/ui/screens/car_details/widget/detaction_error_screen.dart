import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/photo_preview/controller/photo_preview_controller.dart';
import 'package:wtc/ui/shared/custombutton.dart';

class DetectionErrorScreen extends StatelessWidget {
  const DetectionErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: Colors.black.withOpacity(0.90),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2.5),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  AppIcons.carNotFound,
                  height: getWidth(120),
                ),
                SizedBox(
                  height: getHeight(40),
                ),
                Text(
                  "not_found_error".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: getWidth(24)),
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                Text(
                  "meanwhile_".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: const Color(0xffABABAB), fontSize: getWidth(16)),
                ),
                SizedBox(
                  height: getHeight(40),
                ),
                CustomButton(
                    type: CustomButtonType.colourButton,
                    text: "scan_again".tr,
                    padding: kDefaultPadding,
                    onTap: () {
                      Get.back();
                      Get.find<PhotoPreviewController>().errorScreen = false;
                    }),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
