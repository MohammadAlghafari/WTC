import 'dart:async';
import 'dart:convert';

// import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';

import 'package:uni_links/uni_links.dart';
import 'package:wtc/core/constant/app_theme.dart';
import 'package:wtc/core/utils/app_routes.dart';
import 'package:wtc/ui/deepLink.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/camera/get_started_screen.dart';
import 'package:wtc/ui/screens/car_details/model/car_detail_model.dart';

import 'package:wtc/ui/screens/guest/guest_screen.dart';
import 'package:wtc/ui/screens/login/login_screen.dart';

import 'package:wtc/ui/screens/login/model/reset_password_datamodel.dart';
import 'package:wtc/ui/screens/login/widget/reset_password.dart';

import 'package:wtc/ui/screens/splash/splash_screen.dart';
import 'package:wtc/ui/screens/verifyaccount/verification_complete_screen.dart';

import 'core/utils/app_function.dart';
import 'core/utils/bindings.dart';
import 'core/utils/langv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Admob.initialize();
  globalVerbInit();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  StreamSubscription? _sub;
  late StreamSubscription<Map> streamSubscriptionDeepLink;

  void handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen((Uri? uri) {
        debugPrint('got uri: $uri');
        var decoded = Uri.decodeFull(uri!.query);
        final dataQuery = decoded.split(RegExp(r'&|='));
        if (uri.query == "verification1") {
          if (userController.guestLoginFlow) {
            Get.offNamedUntil(VerificationCompleteScreen.routeName, (route) {
              if (route.settings.name == GuestScreen.routeName) {
                userController.guestAsFlow = true;
                return true;
              } else {
                userController.guestAsFlow = false;
                return false;
              }
            });
          } else {
            Get.toNamed(VerificationCompleteScreen.routeName);
          }
        } else if (dataQuery[0] == "reset") {
          Get.toNamed(ResetPasswordScreen.routeName,
              arguments: ResetPasswordDataModel(
                  email: dataQuery[3], token: dataQuery[1]));
        }
      }, onError: (Object err) {
        debugPrint('got err: $err');
      });
    }
  }

  @override
  void initState() {
    // FlutterBranchSdk.validateSDKIntegration();
    Future.delayed(Duration.zero, () {
      listenDeepLinkData(context);
    });
    handleIncomingLinks();
    super.initState();
  }

  @override
  void dispose() {
    _sub?.cancel();
    streamSubscriptionDeepLink.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
        child: child as Widget,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      ),
      translations: Lang(context),
      debugShowCheckedModeBanner: false,
      title: 'WTC',
      initialBinding: BaseBinding(),
      theme: AppTheme.defTheme,
      fallbackLocale: Lang.fallbackLocale,
      locale: Lang.locale,
      initialRoute: SplashScreen.routeName,
      getPages: routes,
    );
  }

  //To Listen Generated Branch IO Link And Get Data From It
  void listenDeepLinkData(BuildContext context) async {
    streamSubscriptionDeepLink = FlutterBranchSdk.initSession().listen((data) {
      print("LISTENLISTEN DEEP LISTEN ${data}");
      if (data.containsKey("+clicked_branch_link") &&
          data["+clicked_branch_link"] == true) {
        if (data["carDetail"] != null) {
          if (userController.token != "") {
            DeepLink.fetchCarSpecifications(
                CarDetailModel.fromJson(jsonDecode(data["carDetail"])));
          } else {
            userController.deepCarDetailModel =
                CarDetailModel.fromJson(jsonDecode(data["carDetail"]));
            Get.toNamed(
              LoginScreen.routeName,
            );
          }
        }
      }
    }, onError: (error) {
      PlatformException platformException = error as PlatformException;
      print(
          "LISTEN DEEP ERR ${platformException.code} - ${platformException.message}");
    });
  }
}

//To Generate Deep Link For Branch Io
Future generateDeepLink(String key, String value) async {
  print("generateDeepLink $key $value");
  BranchUniversalObject buo = BranchUniversalObject(
    canonicalIdentifier: "flutter/branch",
    contentMetadata: BranchContentMetaData()..addCustomMetadata(key, value),
  );
  FlutterBranchSdk.registerView(buo: buo);

  BranchLinkProperties lp = BranchLinkProperties();
  lp.addControlParam('\$uri_redirect_mode', '1');

  BranchResponse response =
      await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
  if (response.success) {
    print("generateDeepLink RES ${response.result}");
    return response.result;
  } else {
    print(
        "generateDeepLink ERROR ${response.errorCode} ${response.errorMessage}");
    flutterToast('${response.errorCode} - ${response.errorMessage}');
    return null;
  }
}
