import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/time_format_extension.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/notification_screen/controller/notification_controller.dart';
import 'package:wtc/ui/shared/custom_appbar.dart';
import 'package:wtc/ui/shared/image_background.dart';


class NotificationScreen extends StatelessWidget {
  static const String routeName= '/NotificationScreen';

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageBackground(
          image: AppBackgrounds.splashBG,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                leadingButtonClick: () {
                  Get.back();
                },
              ),
              header("my_notifications".tr),
              SizedBox(
                height: getHeight(10),
            ),
              // verticalListview()
            ],
          ),),
    );
  }


  verticalListview() {
    return GetBuilder(
      builder: (NotificationController controller) => false
          ? Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 1,
          padding:
          const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {

              },
              child: Container(
                width: Get.width,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    children: [

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
          : Expanded(
        child: Center(
          child: Text("no_data_found".tr),
        ),
      ),
    );
  }

  header(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Text(
        title,
        style: TextStyle(fontSize: getWidth(24), fontWeight: FontWeight.w500),
      ),
    );
  }
}
