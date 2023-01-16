import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_color.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/service/api_routes.dart';
import 'package:wtc/core/service/auth/fbAuth.dart';
import 'package:wtc/core/service/auth/googleAuth.dart';
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/notification_screen/notification_screen.dart';
import 'package:wtc/ui/screens/profile/edit_profile_screen.dart';
import 'package:wtc/ui/screens/profile/widget/delete_my_account_dialog.dart';
import 'package:wtc/ui/screens/recent/recent_screen.dart';
import 'package:wtc/ui/shared/custom_appbar.dart';
import 'package:wtc/ui/shared/image_background.dart';
import 'package:wtc/ui/shared/usercontroller.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfileScreen extends StatelessWidget {
  static const String routeName = "/profileScreen";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageBackground(
        image: AppBackgrounds.splashBG,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              leadingButtonShow: false,
              actionButtonClick: () {
                Get.back();
              },
              actionButtonType: ActionButtonType.cancel,
            ),
            SizedBox(
              height: getHeight(50),
            ),
            centerPortion(context),
            const Spacer(),
            SizedBox(
              height: getHeight(10),
            ),
            Center(
              child: Image.asset(
                AppIcons.landScapeWTFLogo,
                height: 40,
              ),
            ),

            Center(
              child: Text(
                "Contact: contact@whatsthiscar.fr",
                style: TextStyle(color: Colors.white, fontSize: getWidth(18)),
              ),
            ),
            SizedBox(
              height: getHeight(25),
            ),
            Center(
              child: InkWell(
                  child: Text('Partner_with_Carnet'.tr,style: TextStyle(
                      color: Colors.blue,fontSize: getWidth(18))),
                  onTap: () => launch('https://carnet.ai/')
              ),
            ),
            SizedBox(
              height: getHeight(15),
            ),
            Center(
              child: Text(
                "copyright".tr,
                style: TextStyle(
                  fontSize: getWidth(10),
                  color: const Color(0xffBBBBBB),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: SizedBox(
                height: getHeight(30),
              ),
            )
          ],
        ),
      ),
    );
  }

  centerPortion(BuildContext context) {
    return GetBuilder(
      builder: (UserController controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            SizedBox(
              height: getHeight(50),
            ),
            textButton(() {
              Get.toNamed(RecentScreen.routeName);
            }, "my_history".tr),
            SizedBox(
              height: getHeight(10),
            ),
            // textButton(() {
            // Get.toNamed(NotificationScreen.routeName);
            // },"my_notifications".tr),
            //   SizedBox(
            //     height: getHeight(10),
            //   ),
            textButton(() {
              showDeleteAccountDialog(
                  context: context,
                  yesFunction: () {
                    UserRepo.userDeleteAccount();
                  });
            }, "delete_my_account".tr),
            SizedBox(
              height: getHeight(10),
            ),
            textButton(() {
              UserRepo.userLogOut();
              GoogleAuth.signOut();
              FBAuth.signOut();
            }, "log_out".tr),
          ],
        ),
      ),
    );
  }

  GestureDetector textButton(Function()? onTap, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Text(
          title,
          style: TextStyle(fontSize: getWidth(25), fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Row header() {
    return Row(
      children: [
        userPicture(),
        SizedBox(
          width: getWidth(15),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "hi".tr + userController.wtcUserModel.success.firstname,
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: getWidth(34)),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(EditProfileScreen.routeName);
              },
              child: Container(
                color: Colors.transparent,
                child: Text(
                  "edit_profile".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.kPrimaryBlue,
                      fontSize: getWidth(18)),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  userPicture() {
    return GetBuilder(builder: (UserController controller) {
      return controller.profileImage == ""
          ? Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white12),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Image.asset(AppIcons.userProfile),
              ),
            )
          : CachedNetworkImage(
              imageUrl: imageUrl + controller.profileImage,
              height: 60,
              width: 60,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                color: Colors.white30,
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.white30,
              ),
            );
    });
  }
}
