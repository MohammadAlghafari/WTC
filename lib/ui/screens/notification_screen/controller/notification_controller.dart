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

class NotificationController extends GetxController {

  bool _isLoad = true;

  bool get isLoad => _isLoad;

  set isLoad(bool value) {
    _isLoad = value;
    update();
  }

  Future fetchUserHistory() async {
    var response = await UserRepo.fetchUserNotification();
    if (response != null) {

    }

    isLoad = false;
  }

  @override
  void onInit() {
    fetchUserHistory();
    super.onInit();
  }
}
