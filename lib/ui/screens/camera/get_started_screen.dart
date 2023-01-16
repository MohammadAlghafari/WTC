import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/core/utils/shared_prefrences.dart';
import 'package:wtc/ui/screens/camera/widget/bottombar.dart';
import 'package:wtc/ui/screens/camera/widget/camera_button.dart';
import 'package:wtc/ui/screens/camera/widget/topbar.dart';
import 'package:wtc/ui/shared/custombutton.dart';
import 'package:wtc/ui/shared/double_tap_to_back.dart';

import 'controller/get_started_controller.dart';

class GetStartedScreen extends StatefulWidget {
  static const String routeName = "/getStartedScreen";
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with WidgetsBindingObserver {
  final GetStartedController getStartedController =
      Get.find<GetStartedController>();
  @override
  void initState() {
    getStartedController.deepLinkListener();
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      getStartedController.isPrecessing = true;
      getStartedController.controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (getStartedController.controller != null) {
        getStartedController.cameraInitialize();
        return;
      } else if (await Permission.camera.isGranted) {
        getStartedController.cameraInitialize();
        return;
      }
    }
  }

  int _pointers = 0;
  double baseScale = 1.0;
  dynamic currentScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return DoubleBackToCloseApp(
      child: Scaffold(
        key: Get.find<GetStartedController>().scaffoldKey,
        body: GetBuilder(
          id: "updateCameraPreview",
          builder: (GetStartedController controller) => Stack(
            fit: StackFit.expand,
            children: [
              controller.isPrecessing
                  ? const SizedBox.shrink()
                  : cameraWidget(context),
              _buildInterface(),
              blurWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget cameraWidget(context) {
    var camera = getStartedController.controller!.value;

    final size = MediaQuery.of(context).size;

    var scale = size.aspectRatio * camera.aspectRatio;

    if (scale < 1) scale = 1 / scale;
    return Listener(
      onPointerDown: (_) => _pointers++,
      onPointerUp: (_) => _pointers--,
      child: Transform.scale(
        scale: scale,
        child: Center(
          child: CameraPreview(
            getStartedController.controller!,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onScaleStart: _handleScaleStart,
                onScaleUpdate: _handleScaleUpdate,
              );
            }),
          ),
        ),
      ),
    );
  }

  void _handleScaleStart(ScaleStartDetails details) {
    baseScale = currentScale;
    getStartedController.currentScale = currentScale;
    // handleScaleUpdate();
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (getStartedController.controller == null || _pointers != 2) {
      return;
    }
    getStartedController.currentScale = currentScale;

    currentScale = (baseScale * details.scale).clamp(
        getStartedController.minAvailableZoom,
        getStartedController.maxAvailableZoom);

    await getStartedController.controller!.setZoomLevel(currentScale);
  }

  Widget _buildInterface() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  <Widget>[
        const TopBarWidget(
          showRemoveButton: false,
        ),
        const Spacer(),
        Padding(
          padding:const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("point_the".tr,
            style:const TextStyle(color: Color(0xffABABAB),fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        const BottomBarWidget(),
      ],
    );
  }

  Widget blurWidget() {
    return GetBuilder(
      id: "cameraInstructionUpdate",
      builder: (GetStartedController controller) => controller.cameraInstruction
          ? const SizedBox()
          : Container(
              color: Colors.black.withOpacity(0.80),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 2),
                  child: Column(
                    children: [
                      const Spacer(),
                      Image.asset(
                        AppIcons.landScapeWTFLogo,
                        height: getWidth(150),
                        width: getWidth(150),
                      ),
                      const Spacer(),
                      Text(
                        "do_you_want".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: getWidth(24)),
                      ),
                      SizedBox(
                        height: getHeight(12),
                      ),

                      Text(
                        "use_the_button".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: getWidth(16),
                            color: const Color(0xffABABAB)),
                      ),
                      SizedBox(
                        height: getHeight(12),
                      ),
                      Text("vehicle_information".tr,style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: getWidth(16),
                          color: const Color(0xffABABAB)),textAlign: TextAlign.center,),
                      SizedBox(
                        height: getHeight(20),
                      ),
                      CustomButton(
                          type: CustomButtonType.borderButton,
                          text: "got_it".tr,
                          padding: kDefaultPadding,
                          onTap: () async {
                            LocalDB.cameraInstructionRead();
                            await controller.cameraInitialize();
                            controller.cameraInstruction = true;
                          }),
                      const Spacer(
                        flex: 2,
                      ),
                      const RotatedBox(
                          quarterTurns: 1, child: Icon(Icons.arrow_forward)),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          CameraButton(
                            key: const ValueKey('cameraButton'),
                            onTap: () {
                              // Get.find<GetStartedController>().onCapturePressed();
                            },
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                      const SafeArea(top: false, child: SizedBox(height: 30)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
