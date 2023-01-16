import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/camera/controller/get_started_controller.dart';
import 'package:wtc/ui/screens/guest/guest_screen.dart';
import 'package:wtc/ui/screens/photo_preview/controller/car_found_controller.dart';
import 'package:wtc/ui/shared/aleartDialog.dart';
import 'package:wtc/ui/shared/custom_appbar.dart';
import 'package:wtc/ui/shared/custombutton.dart';

class CarFoundScreen extends StatefulWidget {
  static const String routeName = "/carFoundScreen";
  const CarFoundScreen({Key? key}) : super(key: key);

  @override
  State<CarFoundScreen> createState() => _CarFoundScreenState();
}

class _CarFoundScreenState extends State<CarFoundScreen> {
  final CarFoundController carFoundController = Get.find<CarFoundController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3b3b43),
      body: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: Container(
              width: Get.width,
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding)
                  .copyWith(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: Get.width,
                        child: Hero(
                          tag: Get.find<GetStartedController>()
                              .capturedFile!
                              .path,
                          child: Image.file(
                            File(Get.find<GetStartedController>()
                                .capturedFile!
                                .path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 25),
                                Text(
                                  "car_detected".tr,
                                  style: TextStyle(
                                      fontSize: getWidth(13),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff939598)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  carFoundController.carDetailModel.makeName,
                                  style: TextStyle(
                                      fontSize: getWidth(34),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  // "${NumberFormat.percentPattern().format(carFoundController.carDetailModel.probability)} ${"probability".tr}",
                                  "${(carFoundController.carDetailModel.probability ?? 0) * 100}% ${"probability".tr}",
                                  style: TextStyle(
                                      fontSize: getWidth(16),
                                      color: const Color(0xff28A745)),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    titleOrSubtitle(
                                        subTitle: carFoundController
                                            .carDetailModel.color!,
                                        title: "color".tr),
                                    const Spacer(),
                                    titleOrSubtitle(
                                        subTitle: carFoundController
                                                .carDetailModel.modelName +
                                            " " +
                                            carFoundController
                                                .carDetailModel.year!,
                                        title: "model".tr),
                                    const Spacer(),
                                  ],
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                                Center(
                                  child: CustomButton(
                                      type: CustomButtonType.colourButton,
                                      text: "learn_more".tr,
                                      width: getWidth(240),
                                      onTap: () {
                                        if (userController.token != "") {
                                          carFoundController
                                              .fetchCarSpecifications();
                                        } else {
                                          Get.toNamed(GuestScreen.routeName,
                                              arguments: true);
                                        }
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (userController.token != "") {
                                        if (carFoundController.carId != null) {
                                          showCustomDialog(
                                              context: context,
                                              id: carFoundController.carId!);
                                        }
                                      } else {
                                        Get.toNamed(GuestScreen.routeName,
                                            arguments: true);
                                      }
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 50,
                                      width: getWidth(240),
                                      child: Center(
                                        child: Text(
                                          "report_accuracy".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: getWidth(16)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                               /*  Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      carFoundController.shareCarDetail();
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 50,
                                      width: getWidth(240),
                                      child: Center(
                                        child: Text(
                                          "copy_url".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: getWidth(16)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ), */
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget titleOrSubtitle({required String title, required String subTitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: getWidth(13),
            color: const Color(0xff939598),
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: getHeight(5),
      ),
      Text(
        subTitle,
        style: TextStyle(fontSize: getWidth(18), fontWeight: FontWeight.w500),
      ),
    ],
  );
}
