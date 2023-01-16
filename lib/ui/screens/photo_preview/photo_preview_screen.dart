import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/camera/controller/get_started_controller.dart';
import 'package:wtc/ui/screens/photo_preview/controller/photo_preview_controller.dart';
import 'package:wtc/ui/screens/camera/widget/topbar.dart';
import 'package:wtc/ui/screens/car_details/widget/detaction_error_screen.dart';
import 'package:wtc/ui/shared/custombutton.dart';

class PhotoPreviewScreen extends StatefulWidget {
  final Future<File?> file;
  const PhotoPreviewScreen({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  final PhotoPreviewController photoPreviewController =
      Get.find<PhotoPreviewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: FutureBuilder(
                future: widget.file,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    Future.delayed(Duration.zero, () {
                      Get.find<GetStartedController>().capturedFile =
                          XFile(snapshot.data.path);
                    });

                    return Image.file(
                      snapshot.data,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  }
                },
              ),
            ),
            Column(
              children: [
                TopBarWidget(
                  showRemoveButton: true,
                  onTap: () {
                    Get.back();
                  },
                ),
                // const Spacer(),

                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white12),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      SizedBox(
                        width: getWidth(10),
                      ),
                      GetBuilder(
                        builder: (GetStartedController controller) => Stack(
                          children: [
                            CustomButton(
                                type: CustomButtonType.colourButton,
                                width: getWidth(250),
                                text: "wtc".tr,
                                onTap: () {
                                  Get.find<PhotoPreviewController>()
                                      .fetchCarDetail();
                                }),
                            controller.capturedFile != null
                                ? const SizedBox()
                                : Container(
                                    height: 50,
                                    width: getWidth(250),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.50),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SafeArea(
                  top: false,
                  child: SizedBox(
                    height: 40,
                  ),
                )
              ],
            ),
            GetBuilder(
                builder: (PhotoPreviewController controller) =>
                    controller.errorScreen
                        ? const DetectionErrorScreen()
                        : const SizedBox())
          ],
        ),
      ),
    );
  }
}
