import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:wtc/ui/global.dart';

import '../api_handler.dart';
import '../api_routes.dart';

class CarAIRepo {
  static Future fetchCarDetailRepo({
    required File? picture,
  }) async {
    var responseBody = await API.multiPartAPIHandler(
      url: carNetAIUrl,
      header: {
        "Content-Type": "application/octet-stream",
        'Accept': 'application/json',
        "api-key": "a783cdc0-2736-4958-92d1-3c7589672e70",
      },
      multiPartImageKeyName: "carLoad",
      fileImage: picture == null ? null : [picture],
    );
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }

  static Future fetchCarSpecificationsRepo({
    required String makeName,
    required String modelName,
  }) async {
    var responseBody = await API.apiHandler(
      // url: APIRoutes.carSpecification + "/Honda/Accord",
      url: APIRoutes.carSpecification + "/" + makeName + "/" + modelName,
      header: {"Authorization": "Bearer " + userController.token},
    );
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }

  static Future scanUnDetected() async {
    var responseBody = await API.apiHandler(
      url: APIRoutes.undetected,
      showLoader: false,
      showToast: false,
      header: {"Authorization": "Bearer " + userController.token},
    );
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }
}
