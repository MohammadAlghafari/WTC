import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/camera/controller/get_started_controller.dart';
import 'package:wtc/ui/screens/camera/controller/gallery_image_controller.dart';
import 'package:wtc/ui/screens/guest/guest_screen.dart';
import 'package:wtc/ui/screens/recent/recent_screen.dart';
import 'package:wtc/ui/shared/usercontroller.dart';

import 'camera_button.dart';
import 'image_bottomsheet.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              const Spacer(),
              Column(
                children: [
                  GetBuilder(
                    id: "updateFlash",
                    builder: (GetStartedController controller) =>
                        flashNZoomButton(
                      onTap: () {
                        controller.onSetFlashModeButtonPressed();
                      },
                      child: Icon(
                        _getFlashIcon(controller.isPrecessing
                            ? FlashMode.auto
                            : controller.controller!.value.flashMode),
                        size: 20,
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // GetBuilder(
                  //   id: "zoomUpdate",
                  //   builder: (GetStartedController controller) =>
                  //       flashNZoomButton(
                  //     onTap: () {
                  //       controller.handleScaleUpdate();
                  //     },
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(top: 4),
                  //       child: Text(
                  //           "${controller.isPrecessing ? 1 : controller.currentScale.toString().split(".")[0]} x"),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  GetBuilder(
                    id: "zoomUpdate",
                    builder: (GetStartedController controller) =>
                        flashNZoomButton(
                      onTap: () {
                        controller.handleScaleUpdate(ZoomType.zoomIn);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GetBuilder(
                    id: "zoomUpdate",
                    builder: (GetStartedController controller) =>
                        flashNZoomButton(
                      onTap: () {
                        controller.handleScaleUpdate(ZoomType.zoomOut);
                      },
                      child: const Icon(Icons.remove),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Get.find<GalleryImagePicker>().fetchAssets().then((value) {
                    openImageBottomSheet();
                  }).catchError((e) async {
                    if (Platform.isIOS) {
                      await openAppSettings();
                    }
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white12),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Image.asset(AppIcons.photos),
                  ),
                ),
              ),
              CameraButton(
                key: const ValueKey('cameraButton'),
                onTap: () async {
                  if (await Permission.camera.isGranted) {
                    Get.find<GetStartedController>().onCapturePressed();
                  } else {
                    if (Platform.isIOS) {
                      await openAppSettings();
                    } else {
                      if (await Permission.camera.isPermanentlyDenied ||
                          await Permission.camera.isRestricted) {
                        await openAppSettings();
                      } else {
                        Get.find<GetStartedController>().cameraInitialize();
                      }
                    }
                  }
                },
              ),
              GetBuilder(
                builder: (UserController controller) => GestureDetector(
                  onTap: () {
                    if (controller.token != "") {
                      Get.toNamed(RecentScreen.routeName);
                    } else {
                      Get.toNamed(GuestScreen.routeName, arguments: false);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white12),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Image.asset(AppIcons.menu),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SafeArea(top: false, child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  flashNZoomButton({required Function() onTap, required Widget child}) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white12),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }

  IconData _getFlashIcon(FlashMode flashMode) {
    switch (flashMode) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.auto:
        return Icons.flash_auto;
      default:
        return Icons.flash_off;
    }
  }
}
