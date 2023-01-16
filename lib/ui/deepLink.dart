import 'package:get/get.dart';
import 'package:wtc/core/service/repo/car_ai_repo.dart';
import 'package:wtc/ui/screens/car_details/car_detail_screen.dart';
import 'package:wtc/ui/screens/car_details/model/car_detail_model.dart';
import 'package:wtc/ui/screens/car_details/model/custom_car_detal_model.dart';
import 'package:wtc/ui/screens/photo_preview/model/car_feature_model.dart';
import 'package:wtc/ui/screens/photo_preview/model/tab_value_map.dart';

import 'global.dart';

class DeepLink {
  static Future fetchCarSpecifications(CarDetailModel carDetailModel) async {
    final response = await CarAIRepo.fetchCarSpecificationsRepo(
      makeName: carDetailModel.makeName,
      modelName: carDetailModel.modelName,
    );
    if (response != null) {
      final carFeatureModel = CarFeatureModel.fromJson(response);
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
        preventDuplicates: false,
        arguments: CustomCarDetailModel(
            makeName: carDetailModel.makeName,
            year: carDetailModel.year,
            modelName: carDetailModel.modelName,
            catTabData: Get.locale!.countryCode == "FRA" ? dupMapFr : dupMap,
            color: carDetailModel.color,
            id: carDetailModel.carId,
            image: null,
            probability: carDetailModel.probability,
            otherCarList: carFeatureModel.success.otherCars),
      );
    }
  }
}
