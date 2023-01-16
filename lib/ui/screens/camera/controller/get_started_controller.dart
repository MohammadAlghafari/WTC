import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wtc/core/utils/shared_prefrences.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/car_details/model/car_detail_model.dart';
import 'package:wtc/ui/screens/photo_preview/photo_preview_screen.dart';

import '../../../deepLink.dart';

class GetStartedController extends GetxController {
  bool _isPrecessing = true;

  bool get isPrecessing => _isPrecessing;

  set isPrecessing(bool value) {
    _isPrecessing = value;
    update(["updateCameraPreview"]);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  CameraController? controller;
  double minAvailableZoom = 1.0;
  double maxAvailableZoom = 1.0;
  Future cameraInitialize() async {
    PermissionStatus cameraPermission = await Permission.camera.request();
    if (cameraPermission.isGranted) {
      await availableCameras().then((availableCameras) {
        cameras = availableCameras;
        if (cameras.isNotEmpty) {
          selectedCameraIdx = 0;

          initCameraController(cameras[selectedCameraIdx])
              .then((void v) {})
              .catchError((e) {});
        } else {
          print("No camera available");
        }
      });
    }
  }

  Future initCameraController(CameraDescription cameraDescription) async {
    try {
      if (controller != null) {
        await controller!.dispose();
      }

      controller = CameraController(cameraDescription, ResolutionPreset.high,
          enableAudio: false);

      controller!.addListener(() {
        if (controller!.value.hasError) {
          print('Camera error ${controller!.value.errorDescription}');
        }
      });

      await controller!.initialize().then((value) {
        controller!.lockCaptureOrientation(DeviceOrientation.portraitUp);
        controller!.setFlashMode(FlashMode.off);
        isPrecessing = false;
        currentScale = 1;
        controller!.getMaxZoomLevel().then((value) => maxAvailableZoom = value);
        controller!.getMinZoomLevel().then((value) => minAvailableZoom = value);
      });
    } on CameraException catch (e) {
      // await openAppSettings();
      // Get.offNamed(LandingScreen.routeName);
      return Future.error(e);
    }
  }

  List cameras = [];
  int _selectedCameraIdx = -1;

  int get selectedCameraIdx => _selectedCameraIdx;

  set selectedCameraIdx(int value) {
    _selectedCameraIdx = value;
    update();
  }

  void onSetFlashModeButtonPressed() {
    switch (controller!.value.flashMode) {
      case FlashMode.off:
        setFlashMode(FlashMode.always);
        break;
      case FlashMode.always:
        setFlashMode(FlashMode.auto);
        break;
      case FlashMode.auto:
        setFlashMode(FlashMode.off);
        break;
      default:
        setFlashMode(FlashMode.off);
    }
  }

  Future<void> setFlashMode(FlashMode mode) async {
    try {
      await controller!.setFlashMode(mode);
      update(["updateFlash"]);
    } on CameraException catch (e) {}
  }

  XFile? _capturedFile;

  XFile? get capturedFile => _capturedFile;

  set capturedFile(XFile? value) {
    _capturedFile = value;
    update();
  }

  void onCapturePressed() async {
    capturedFile = null;

    capturedFile = await controller!.takePicture().then((value) {
      if (value.path.isNotEmpty) {
        Navigator.push(
            Get.context as BuildContext,
            MaterialPageRoute(
              builder: (context) => PhotoPreviewScreen(
                file: Future.delayed(Duration.zero, () => File(value.path)),
              ),
            ));

        return value;
      }
    });
  }

  dynamic _currentScale = 1.0;

  dynamic get currentScale => _currentScale;

  set currentScale(dynamic value) {
    _currentScale = value;
    update(['zoomUpdate']);
  }

  Future<void> handleScaleUpdate(ZoomType zoomType) async {
    if (zoomType == ZoomType.zoomIn) {
      if (maxAvailableZoom.toInt() == currentScale) {
        currentScale = 1.0;
        await controller!.setZoomLevel(1.0);
        return;
      }
      currentScale =
          (currentScale + 1).clamp(minAvailableZoom, maxAvailableZoom);
    } else {
      currentScale =
          (currentScale - 1).clamp(minAvailableZoom, maxAvailableZoom);
    }

    await controller!.setZoomLevel(currentScale * 1.0);
    update();
  }

  bool _cameraInstruction = LocalDB.cameraInstructionRead();

  bool get cameraInstruction => _cameraInstruction;

  set cameraInstruction(bool value) {
    _cameraInstruction = value;
    update(["cameraInstructionUpdate"]);
  }

  deepLinkListener() {
    if (userController.deepCarDetailModel != null &&
        userController.token != "") {
      Future.delayed(const Duration(milliseconds: 500), () {
        DeepLink.fetchCarSpecifications(userController.deepCarDetailModel!);
        userController.deepCarDetailModel = null;
      });
    }
  }

  @override
  void onInit() {
    if (cameraInstruction) {
      cameraInitialize();
    }

    super.onInit();
  }
}

enum ZoomType { zoomIn, zoomOut }
