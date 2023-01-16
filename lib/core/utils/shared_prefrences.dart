import 'package:get_storage/get_storage.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/login/model/wtc_user_model.dart';

class LocalDB {
  static final sharedPreference = GetStorage();

  static bool cameraInstructionRead() {
    if (sharedPreference.read("firstTimeLunch") == null) {
      sharedPreference.write("firstTimeLunch", true);
      return false;
    } else {
      return true;
    }
  }

  static bool onBoardingRead() {
    if (sharedPreference.read("onBoardingRead") == null) {
      sharedPreference.write("onBoardingRead", true);
      return false;
    } else {
      return true;
    }
  }

  static saveUserDetails(WtcUserModel wtcUserModel) {
    sharedPreference.write("WtcUser", wtcUserModel.toJson());
    userController.wtcUserModel = wtcUserModel;
  }

  static bool getUserDetails() {
    var userData = sharedPreference.read("WtcUser");
    if (userData == null) {
      return false;
    } else {
      userController.wtcUserModel = WtcUserModel.fromJson(userData);
      return true;
    }
  }

  static void clearData() {
    sharedPreference.remove("WtcUser");
  }
}
