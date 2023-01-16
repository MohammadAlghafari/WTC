import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wtc/core/constant/app_asset.dart';

class LoadingOverlay {
  void hide() {
    Get.back();
  }

  void show() {
    Get.dialog(
      FullScreenLoader(),
      barrierDismissible: false,
    );
    // showDialog(
    //   context: _context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) => FullScreenLoader(),
    // );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create();

  factory LoadingOverlay.of() {
    return LoadingOverlay._create();
  }
}

class FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
        child: Center(
          child: AppLoader(),
        ),
      ),
    );
  }
}

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: getLoader(),
            ),
          ],
        ),
      ),
    );
  }

  getLoader() {
    return Lottie.asset(AppLottie.appLoader, height: 80, width: 80);
  }
}
