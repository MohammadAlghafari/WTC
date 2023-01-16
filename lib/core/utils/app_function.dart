import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_settings.dart';

import 'package:wtc/ui/global.dart';

void flutterToast(String msg) async {
  ScaffoldMessenger.of(Get.context as BuildContext).hideCurrentSnackBar();
  String message;
  if (Get.locale!.languageCode == "fr") {
    message =
        await translator.translate(msg, to: 'fr').then((value) => value.text);
  } else {
    message = msg;
  }
  // Get.showSnackbar(GetSnackBar(
  //   message: message,
  //   duration: const Duration(seconds: 2),
  //   snackPosition: SnackPosition.TOP,
  // ));
  ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.black),
    ),
    width: Get.width - (kDefaultPadding * 2),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: Colors.white,
  ));

  // return Fluttertoast.showToast(
  //     msg: message,
  //     textColor: Colors.black,
  //     toastLength: message.length > 20 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
  //     backgroundColor: Colors.white,
  //     fontSize: 14);
}

checkConnection() async {
  ConnectivityResult result = await Connectivity().checkConnectivity();
  return (result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi);
}

void disposeKeyboard() {
  return FocusManager.instance.primaryFocus?.unfocus();
}
