import 'package:get/get.dart';
import 'package:wtc/ui/screens/car_details/model/car_detail_model.dart';
import 'package:wtc/ui/screens/login/model/wtc_user_model.dart';

class UserController extends GetxController {
  WtcUserModel _wtcUserModel = WtcUserModel(success: Success());

  WtcUserModel get wtcUserModel => _wtcUserModel;

  set wtcUserModel(WtcUserModel value) {
    _wtcUserModel = value;
    update();
  }

  //give token
  String get token => wtcUserModel.success.token;
  String get profileImage => wtcUserModel.success.profileImg;

  bool guestLoginFlow = false;
  bool guestAsFlow = true;
  bool saveHistory = false;
  CarDetailModel? deepCarDetailModel;
}
