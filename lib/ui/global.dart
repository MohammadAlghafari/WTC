import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:translator/translator.dart';
import 'package:wtc/core/utils/shared_prefrences.dart';
import 'package:wtc/ui/screens/camera/get_started_screen.dart';
import 'package:wtc/ui/screens/landing/landing_screen.dart';
import 'package:wtc/ui/shared/imagePicker.dart';
import 'package:wtc/ui/shared/usercontroller.dart';

late AppImagePicker appImagePicker;
late UserController userController;
late GoogleTranslator translator;
globalVerbInit() async {
  GetStorage.init();
  translator = GoogleTranslator();
  appImagePicker = AppImagePicker();
  userController = Get.put(UserController());
}

String getInitialRoute() {
  if (LocalDB.getUserDetails()) {
    return GetStartedScreen.routeName;
  } else {
    return LandingScreen.routeName;
  }
}
