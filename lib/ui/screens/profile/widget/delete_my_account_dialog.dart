import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/shared/custombutton.dart';

Future showDeleteAccountDialog(
    {required BuildContext context, required Function yesFunction}) async {
  return showDialog<void>(
    context: context,
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
                    "delete_my_account_confirmation".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: getWidth(28), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      type: CustomButtonType.colourButton,
                      text: "yes".tr,
                      onTap: () {
                        yesFunction();
                        Get.back();
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      type: CustomButtonType.borderButton,
                      text: "no".tr,
                      onTap: () {
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
