import 'dart:developer';

import 'package:get/get.dart';
import 'package:wtc/core/service/api_routes.dart';
import 'package:wtc/core/service/repo/car_ai_repo.dart';
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/ui/screens/car_details/car_detail_screen.dart';
import 'package:wtc/ui/screens/car_details/model/custom_car_detal_model.dart';
import 'package:wtc/ui/screens/photo_preview/controller/photo_preview_controller.dart';
import 'package:wtc/ui/screens/photo_preview/model/car_feature_model.dart';
import 'package:wtc/ui/screens/photo_preview/model/tab_value_map.dart';
import 'package:wtc/ui/screens/recent/model/other_seach_history_model.dart';
import 'package:wtc/ui/screens/recent/model/search_history_model.dart';

import '../../../global.dart';

class RecentController extends GetxController {
  SearchHistoryModel? _searchHistoryModel;
  OtherSearchHistoryModel? _otherSearchHistoryModel;
  List<MyScanHistory> get myScanHistory =>
      _searchHistoryModel!.searchData.myScanHistory;
  List<MyScanHistory> get otherScanHistory =>
      _otherSearchHistoryModel!.otherSearchData.otherScanHistory;
  bool _isLoad = true;

  bool get isLoad => _isLoad;

  set isLoad(bool value) {
    _isLoad = value;
    update();
  }

  Future fetchUserHistory() async {
    var response = await UserRepo.fetchUserHistoryRepo();
    if (response != null) {
      var response2 = await UserRepo.otherUserHistoryRepo();
      if (response != null && response2 != null) {
        _searchHistoryModel = SearchHistoryModel.fromJson(response);
        _otherSearchHistoryModel = OtherSearchHistoryModel.fromJson(response2);
      }
    }

    isLoad = false;
  }

  Future fetchCarSpecifications({
    required MyScanHistory myScanHistory,
  }) async {
    final response = await CarAIRepo.fetchCarSpecificationsRepo(
      makeName: myScanHistory.carMake,
      modelName: myScanHistory.carModel,
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
        arguments: CustomCarDetailModel(
            makeName: myScanHistory.carMake,
            modelName: myScanHistory.carModel,
            year: myScanHistory.year,
            catTabData: Get.locale!.countryCode == "FRA" ? dupMapFr : dupMap,
            color: myScanHistory.color,
            image: myScanHistory.carImg == "" ? null : myScanHistory.carImg,
            isFileImage: false,
            probability: myScanHistory.probability,
            otherCarList: CarFeatureModel.fromJson(response).success.otherCars),
      );
    }
  }

  @override
  void onInit() {
    fetchUserHistory();
    super.onInit();
  }
}
