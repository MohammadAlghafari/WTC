import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/service/api_routes.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/camera/controller/get_started_controller.dart';
import 'package:wtc/ui/screens/guest/guest_screen.dart';
import 'package:wtc/ui/screens/profile/widget/profile_screen.dart';
import 'package:wtc/ui/screens/verifyaccount/verification_complete_screen.dart';
import 'package:wtc/ui/shared/aleartDialog.dart';
import 'package:wtc/ui/shared/usercontroller.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({Key? key, required this.showRemoveButton, this.onTap})
      : super(key: key);
  final bool showRemoveButton;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: GetBuilder(
        builder: (GetStartedController controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      // onTap: () async {
                      //   showCustomDialog(context: context);
                      // },
                      child: Image.asset(
                        AppIcons.landScapeWTFLogo,
                      ),
                    ),
                    const Spacer(),
                    showRemoveButton
                        ? GestureDetector(
                            onTap: onTap,
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white12),
                                child: const Icon(Icons.close)),
                          )
                        : GetBuilder(
                            builder: (UserController controller) {
                              return GestureDetector(
                                onTap: () {
                                  if (controller.token != "") {
                                    Get.toNamed(ProfileScreen.routeName);
                                  } else {
                                    Get.toNamed(GuestScreen.routeName,
                                        arguments: false);
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: controller.profileImage == ""
                                          ? null
                                          : DecorationImage(
                                              image: NetworkImage(imageUrl +
                                                  controller.profileImage),
                                              fit: BoxFit.cover),
                                      color: Colors.white24),
                                  child: controller.token != ""
                                      ? controller.profileImage == ""
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(13.0),
                                              child: Image.asset(
                                                  AppIcons.userProfile),
                                            )
                                          : const SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child:
                                              Image.asset(AppIcons.userProfile),
                                        ),
                                ),
                              );
                            },
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
