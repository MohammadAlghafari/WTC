import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wtc/core/service/repo/car_ai_repo.dart';
import 'package:wtc/ui/screens/car_details/model/car_detail_model.dart';

import 'package:wtc/ui/screens/car_details/model/custom_car_detal_model.dart';
import 'package:wtc/ui/screens/photo_preview/model/car_feature_model.dart';
import 'package:wtc/ui/screens/photo_preview/model/tab_value_map.dart';

import '../../../../main.dart';
import '../../../global.dart';
import '../car_detail_screen.dart';

class CarDetailController extends GetxController {
  ScrollController scrollController = ScrollController();
  double _scrollPercent = 0.0;

  double get scrollPercent => _scrollPercent;

  set scrollPercent(double value) {
    _scrollPercent = value;
    update();
  }

  Future fetchOtherCarData(OtherCar otherCar) async {
    final response = await CarAIRepo.fetchCarSpecificationsRepo(
      makeName: otherCar.makeName,
      modelName: otherCar.modelName,
    );
    if (response != null) {
      List specData = response["success"]["car_specification_feature"];
      // Map<String, Map<String, dynamic>> dupMap = carTabData;
      // for (dynamic data in specData) {
      //   for (String outerKey in carTabData.keys) {
      //     dupMap[outerKey]!.forEach((key, value) {
      //       if (data["car_specification_name"] == key) {
      //         dupMap[outerKey]![key] = "${data["value"]} ${data["unit"] ?? ""}";
      //       }
      //     });
      //   }
      // }
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
        preventDuplicates: false,
        arguments: CustomCarDetailModel(
            makeName: otherCar.makeName,
            year: otherCar.year,
            modelName: otherCar.modelName,
            catTabData: Get.locale!.countryCode == "FRA" ? dupMapFr : dupMap,
            probability: null,
            otherCarList: CarFeatureModel.fromJson(response).success.otherCars),
      );
    }
  }

  Future<String> getShareUrl() async {
    var result = await generateDeepLink(
        "carDetail",
        jsonEncode(CarDetailModel(
                carId: customCarDetailModel.id,
                makeName: customCarDetailModel.makeName,
                modelName: customCarDetailModel.modelName,
                color: customCarDetailModel.color,
                generationName: customCarDetailModel.generationName,
                isSuccess: true,
                probability:
                    double.parse(customCarDetailModel.probability.toString()),
                year: customCarDetailModel.year)
            .toJson()));
    return result.toString();
  }

  shareCarDetail() async {
    var result = await getShareUrl();
    Share.share('What\'s this car?, Regarde cette voiture\n$result',
        subject: 'Hi');
  }

  late CustomCarDetailModel customCarDetailModel;

  @override
  void onInit() async {
    customCarDetailModel = Get.arguments;
    log("RAANA CarDetailController ${customCarDetailModel.catTabData}");
    scrollController.addListener(() {
      scrollPercent = scrollController.offset;
    });
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    scrollController.dispose();
    super.dispose();
  }

  final String? tag;

  CarDetailController({this.tag});
}
