import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wtc/core/service/repo/car_ai_repo.dart';
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/ui/screens/camera/controller/get_started_controller.dart';
import 'package:wtc/ui/screens/car_details/car_detail_screen.dart';
import 'package:wtc/ui/screens/car_details/model/car_detail_model.dart';
import 'package:wtc/ui/screens/car_details/model/custom_car_detal_model.dart';
import 'package:wtc/ui/screens/guest/guest_screen.dart';
import 'package:wtc/ui/screens/photo_preview/controller/photo_preview_controller.dart';
import 'package:wtc/ui/screens/photo_preview/model/car_feature_model.dart';
import 'package:wtc/ui/screens/photo_preview/model/tab_value_map.dart';

import '../../../../main.dart';
import '../../../global.dart';

class CarFoundController extends GetxController {
  late CarDetailModel carDetailModel;
  Future saveToHistory({bool? showLoader}) async {
    if (userController.token != "") {
      carId = null;
      await UserRepo.saveHistory(
              file: File(Get.find<GetStartedController>().capturedFile!.path),
              probability: carDetailModel.probability.toString(),
              showLoader: showLoader ?? false,
              color: carDetailModel.color!,
              makeName: carDetailModel.makeName,
              modelName: carDetailModel.modelName,
              generationName: carDetailModel.generationName!,
              year: carDetailModel.year!)
          .then((value) {
        carDetailModel.carId = value["success"]["id"];
        carId = value["success"]["id"];
      });
    }
  }

  Future fetchCarSpecifications() async {
    final response = await CarAIRepo.fetchCarSpecificationsRepo(
      makeName: carDetailModel.makeName,
      modelName: carDetailModel.modelName,
    );
    if (response != null) {
      carFeatureModel = CarFeatureModel.fromJson(response);
      List specData = response["success"]["car_specification_feature"];
      Map<String, Map<String, dynamic>> dupMap = Map.from(carTabDataEng);
      Map<String, Map<String, dynamic>> dupMapFr = Map.from(carTabData);
      for (dynamic data in specData) {
        for (String outerKey in carTabDataEng.keys) {
          dupMap[outerKey]!.forEach((key, value) async {
            if (data["car_specification_name"] == key) {
              dupMap[outerKey]![key] = "${data["value"]} ${data["unit"] ?? ""}";
              if (Get.locale!.countryCode == "FRA") {
                var k = await translator
                    .translate("${data["value"]} ${data["unit"] ?? ""}",
                        to: "fr", from: "en")
                    .then((value) => value.text);
                dupMapFr[outerKey.tr]![key.tr] = k;
              }
            }
          });
        }
      }
      Get.toNamed(
        CarDetailScreen.routeName,
        arguments: CustomCarDetailModel(
            makeName: carDetailModel.makeName,
            modelName: carDetailModel.modelName,
            year: carDetailModel.year,
            catTabData: Get.locale!.countryCode == "FRA" ? dupMapFr : dupMap,
            color: carDetailModel.color,
            id: carId,
            image: File(Get.find<GetStartedController>().capturedFile!.path),
            probability: carDetailModel.probability,
            otherCarList: carFeatureModel.success.otherCars),
      );
    }
  }

  Future<String> getShareUrl() async {
    var result = await generateDeepLink(
        "carDetail", jsonEncode(carDetailModel.toJson()));
    return result.toString();
  }

  shareCarDetail() async {
    var result = await generateDeepLink(
        "carDetail", jsonEncode(carDetailModel.toJson()));
    if (result != null) {
      Share.share('What\'s this car?, check out this car\n$result',
          subject: 'Hi');
    }
  }

  late CarFeatureModel carFeatureModel;
  String get carName =>
      carFeatureModel.success.carMakeModelGeneration.makeName +
      " " +
      carFeatureModel.success.carMakeModelGeneration.modelName;

  int? carId;
  @override
  void onInit() {
    carDetailModel = Get.arguments;
    saveToHistory();
    super.onInit();
  }
}
