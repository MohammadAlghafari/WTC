import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_color.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/core/utils/shared_prefrences.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/camera/controller/get_started_controller.dart';
import 'package:wtc/ui/screens/camera/get_started_screen.dart';
import 'package:wtc/ui/shared/custom_appbar.dart';
import 'package:wtc/ui/shared/custombutton.dart';
import 'package:wtc/ui/shared/image_background.dart';

import 'controller/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String routeName = "/onBoardingScreen";

  OnBoardingScreen({Key? key}) : super(key: key);
  final PageController pageController = PageController(initialPage: 0);
  final OnBoardingController onBoardingController =
      Get.find<OnBoardingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        builder: (OnBoardingController controller) => Stack(
          children: [
            PageView(
              scrollBehavior: MyBehavior(),
              children: [
                buildColumn(
                    index: 1,
                    image: AppBackgrounds.obdBG1,
                    text: 'obd1title'.tr,
                    subtitle: 'obd1'.tr),
                buildColumn(
                    index: 2,
                    image: AppBackgrounds.obdBG2,
                    text: 'obd2title'.tr,
                    subtitle: 'obd2'.tr),
                buildColumn(
                    index: 3,
                    image: AppBackgrounds.obdBG3,
                    text: 'obd3title'.tr,
                    subtitle: 'obd3'.tr),
              ],
              controller: pageController,
              onPageChanged: (val) {
                controller.index = val;
              },
            ),
            Column(
              children: [
                CustomAppBar(
                  actionButtonType: ActionButtonType.skip,
                  leadingButtonClick: () {
                    if (onBoardingController.index == 0) {
                      Get.back();
                    } else {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  actionButtonClick: () async {
                    LocalDB.onBoardingRead();

                    if (userController.guestLoginFlow) {
                      Get.back();
                      Get.back();
                    } else {
                      Get.offAllNamed(GetStartedScreen.routeName);
                    }
                  },
                ),
                const Spacer(),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 2),
                      child: GetBuilder(
                          builder: (OnBoardingController controller) =>
                              PaginationDot(
                                currentIndex: controller.index,
                              )),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.30,
                ),
                GetBuilder(
                  builder: (OnBoardingController controller) => CustomButton(
                      type: CustomButtonType.colourButton,
                      text: controller.index == 2 ? "let's_go".tr : "next".tr,
                      padding: kDefaultPadding * 2,
                      onTap: () async {
                        LocalDB.onBoardingRead();

                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        if (controller.index == 2) {
                          if (userController.guestLoginFlow) {
                            Get.back();
                            Get.back();
                          } else {
                            Get.offAllNamed(GetStartedScreen.routeName);
                          }
                        }
                      }),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColumn(
      {required String image,
      required String text,
      required String subtitle,
      required int index}) {
    return ImageBackground(
      image: image,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            SizedBox(
              height: Get.height * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: getWidth(34), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    subtitle,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: getWidth(16),
                      color: const Color(0xffABABAB),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class PaginationDot extends StatefulWidget {
  final int currentIndex;
  const PaginationDot({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _PaginationDotState createState() => _PaginationDotState();
}

class _PaginationDotState extends State<PaginationDot> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          3,
          (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: EdgeInsets.only(right: index == 3 - 1 ? 0 : 3),
                width:
                    (index) == widget.currentIndex ? getWidth(12) : getWidth(5),
                height: getWidth(5),
                decoration: BoxDecoration(
                  color: index == widget.currentIndex
                      ? AppColor.kPrimaryBlue
                      : const Color(0xffBFBFBF),
                  borderRadius: BorderRadius.circular(8),
                ),
              )),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
