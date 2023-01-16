import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_color.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/shared/custombutton.dart';

import '../../register/widget/privacy_police_widget.dart';

Future showAcceptPrivacyPolicyDialog(
    {required BuildContext context, required Function signInFunction}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.white.withOpacity(0.30),
    builder: (BuildContext context) {
      return AcceptPrivacyPolicyDialog(
        signInFunction: signInFunction,
      );
    },
  );
}

class AcceptPrivacyPolicyDialog extends StatefulWidget {
  const AcceptPrivacyPolicyDialog({
    Key? key,
    required this.signInFunction,
  }) : super(
          key: key,
        );

  final Function signInFunction;

  @override
  State<AcceptPrivacyPolicyDialog> createState() =>
      _AcceptPrivacyPolicyDialogState();
}

class _AcceptPrivacyPolicyDialogState extends State<AcceptPrivacyPolicyDialog> {
  bool confirmed = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
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
                Row(
                  children: [
                    Checkbox(
                        value: confirmed,
                        fillColor:
                            MaterialStateProperty.all(AppColor.kPrimaryBlue),
                        onChanged: (value) {
                          setState(() {
                            confirmed = !confirmed;
                          });
                        }),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showPrivacyPoliceDialog(context: context);
                        },
                        child: Text(
                          "conditions_acceptance".tr,
                          style: TextStyle(
                              color: AppColor.kPrimaryBlue,
                              decoration: TextDecoration.underline,
                              fontSize: getWidth(16)),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                    type: CustomButtonType.colourButton,
                    text: "ok".tr,
                    onTap: () async {
                      if (confirmed) {
                        widget.signInFunction();
                        Get.back();
                      }
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
  }
}
