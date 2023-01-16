import 'package:get/get.dart';
import 'package:wtc/ui/screens/camera/controller/gallery_image_controller.dart';
import 'package:wtc/ui/screens/camera/controller/get_started_controller.dart';
import 'package:wtc/ui/screens/login/controller/forgot_password_controller.dart';
import 'package:wtc/ui/screens/login/controller/login_controller.dart';
import 'package:wtc/ui/screens/login/controller/reset_password_controller.dart';
import 'package:wtc/ui/screens/onboarding/controller/onboarding_controller.dart';
import 'package:wtc/ui/screens/photo_preview/controller/car_found_controller.dart';
import 'package:wtc/ui/screens/photo_preview/controller/photo_preview_controller.dart';
import 'package:wtc/ui/screens/profile/controller/change_password_controller.dart';
import 'package:wtc/ui/screens/profile/controller/edit_profile_controller.dart';
import 'package:wtc/ui/screens/recent/controller/recent_controller.dart';
import 'package:wtc/ui/screens/register/controller/register_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<RegisterController>(() => RegisterController(), fenix: true);
    Get.lazyPut<OnBoardingController>(() => OnBoardingController(),
        fenix: true);
    Get.lazyPut<GetStartedController>(() => GetStartedController(),
        fenix: true);
    Get.lazyPut<EditProfileController>(() => EditProfileController(),
        fenix: true);
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController(),
        fenix: true);
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController(),
        fenix: true);
    Get.lazyPut<PhotoPreviewController>(() => PhotoPreviewController(),
        fenix: true);
    Get.lazyPut<RecentController>(() => RecentController(), fenix: true);
    Get.lazyPut<GalleryImagePicker>(() => GalleryImagePicker(), fenix: true);
    Get.lazyPut<CarFoundController>(() => CarFoundController(), fenix: true);
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController(),
        fenix: true);
  }
}
