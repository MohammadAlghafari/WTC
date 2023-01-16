import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wtc/core/service/repo/car_ai_repo.dart';
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/car_details/car_detail_screen.dart';
import 'package:wtc/ui/screens/car_details/model/car_detail_model.dart';
import 'package:wtc/ui/screens/guest/guest_screen.dart';
import 'package:wtc/ui/screens/photo_preview/model/car_feature_model.dart';
import 'package:wtc/ui/screens/photo_preview/widget/car_found_screen.dart';

import '../../../../main.dart';
import '../../camera/controller/get_started_controller.dart';

class PhotoPreviewController extends GetxController {
  late CarDetailModel carDetailModel;
  String get probability => carDetailModel.probability.toString();

  Future fetchCarDetail() async {
    final response = await CarAIRepo.fetchCarDetailRepo(
        picture: File(Get.find<GetStartedController>().capturedFile!.path));
    if (response != null) {
      if (response["is_success"]) {
        if (response["detections"].isNotEmpty) {
          if (response["detections"][0]["mmg"].isNotEmpty) {
            carDetailModel = CarDetailModel(
              makeName: response["detections"][0]["mmg"][0]["make_name"] ?? "",
              modelName:
                  response["detections"][0]["mmg"][0]["model_name"] ?? "",
              generationName:
                  response["detections"][0]["mmg"][0]["generation_name"] ?? "",
              isSuccess: response["is_success"] ?? false,
              probability:
                  response["detections"][0]["mmg"][0]["probability"] ?? 0.0,
              year: response["detections"][0]["mmg"][0]["years"] ?? "",
              color: response["detections"][0]["color"][0]["name"] ?? "",
            );
            Get.offNamed(CarFoundScreen.routeName, arguments: carDetailModel);
          } else {
            errorScreen = true;
            scanUnDetected();
          }
        } else {
          errorScreen = true;
          scanUnDetected();
        }
      } else {
        errorScreen = true;
      }
    }
  }

  Future scanUnDetected() async {
    if (userController.token != "") {
      await CarAIRepo.scanUnDetected();
    }
  }

  bool _errorScreen = false;

  bool get errorScreen => _errorScreen;

  set errorScreen(bool value) {
    _errorScreen = value;
    update();
  }
}
