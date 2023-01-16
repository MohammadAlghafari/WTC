import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_color.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/shared/custombutton.dart';

Future showShareDialog(
    {required BuildContext context,
    required String url,
    required Function shareFunction}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.white.withOpacity(0.30),
    builder: (BuildContext context) {
      return Dialog(
        insetPadding:
            const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
        child: FittedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: Get.width,
              color: Colors.black,
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2.5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Image.asset(
                    AppIcons.landScapeWTFLogo,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    'URL',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: getWidth(28), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    url,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: getWidth(18),
                        fontWeight: FontWeight.w400,
                        color: AppColor.kPrimaryBlue),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      type: CustomButtonType.colourButton,
                      text: "copy".tr,
                      onTap: () async {
                        shareFunction();
                        Get.back();
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      type: CustomButtonType.borderButton,
                      text: "cancel".tr,
                      onTap: () async {
                        Get.back();
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
