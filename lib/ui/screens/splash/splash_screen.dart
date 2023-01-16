import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/ui/global.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final Future<LottieComposition> _composition;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load(AppLottie.splashLottie);
    return await LottieComposition.fromByteData(assetData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: _composition,
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          _controller = AnimationController(
            duration: const Duration(seconds: (2)),
            vsync: this,
          )..forward().whenComplete(() => Get.offNamed(getInitialRoute()));

          return Scaffold(
            body: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: Lottie(
                  composition: composition,
                  controller: _controller,
                  // height: Get.height,
                  // width: Get.width,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
