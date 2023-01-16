import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/time_format_extension.dart';
import 'package:wtc/core/service/api_routes.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/recent/controller/recent_controller.dart';
import 'package:wtc/ui/shared/custom_appbar.dart';
import 'package:wtc/ui/shared/image_background.dart';
import 'package:get/get.dart';

class RecentScreen extends StatelessWidget {
  static const String routeName = "/recentScreen";

  const RecentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageBackground(
          image: AppBackgrounds.splashBG,
          child: GetBuilder(
            builder: (RecentController controller) => controller.isLoad
                ? Container(
                    color: Colors.transparent,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(
                        leadingButtonClick: () {
                          Get.back();
                        },
                      ),
                      header("recent".tr),
                      SizedBox(
                        height: getHeight(10),
                      ),
                      horizontalListview(controller),
                      SizedBox(
                        height: getHeight(20),
                      ),
                      header("history".tr),
                      SizedBox(
                        height: getHeight(10),
                      ),
                      verticalListview(controller)
                    ],
                  ),
          )),
    );
  }

  horizontalListview(RecentController controller) {
    return  controller.otherScanHistory.isNotEmpty
          ? SizedBox(
            height: getHeight(205),
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.otherScanHistory.length,
                itemBuilder: (BuildContext context ,int index){
                  var e = controller.otherScanHistory[index];
                  return GestureDetector(
                      onTap: () {
                        controller.fetchCarSpecifications(myScanHistory: e);
                      },
                      child: Container(
                        height: 205,
                        width: getWidth(140),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: Get.width,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    child: Image.network(
                                      otherImageUrl + e.carImg,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                          Image.asset(
                                            AppIcons.placeHolder,
                                            fit: BoxFit.cover,
                                          ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -9,
                                  left: 20,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        image: DecorationImage(
                                          image: e.useProfile == ""
                                              ? const AssetImage(
                                              AppIcons.wtcPlaceHolder)
                                              : NetworkImage(imageUrl +
                                              e.useProfile)
                                          as ImageProvider,
                                          onError:
                                              (exception, stackTrace) =>
                                              Container(
                                                height: 18,
                                                width: 18,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  color: Colors.grey,
                                                ),
                                              ),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(5)),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 12, top: 12),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    e.carName,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: getWidth(16)),
                                  ),
                                  e.generation == null && e.year == null
                                      ? const SizedBox()
                                      : Text(
                                    controller.otherScanHistory[0]
                                        .generation! +
                                        " " +
                                        e.year.toString(),
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: getWidth(13),
                                        color:
                                        const Color(0xffABABAB)),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    DateTimeFormatExtension
                                        .displayTimeFromTimestampForPost(
                                        e.foundDate.toLocal()),
                                    style: TextStyle(
                                        fontSize: getWidth(12),
                                        color: const Color(0xff939598)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                  );
                },
              ),
          )
          : Center(child: Text("no_data_found".tr),
    );
  }

  verticalListview(RecentController controller) {
    return  controller.myScanHistory.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                itemCount: controller.myScanHistory.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.fetchCarSpecifications(
                          myScanHistory: controller.myScanHistory[index]);
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
                            carPicture(controller.myScanHistory[index].carImg),
                            SizedBox(
                              width: getWidth(10),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.myScanHistory[index].carName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: getWidth(16)),
                                ),
                                controller.myScanHistory[index].generation == ""
                                    ? const SizedBox()
                                    : Text(
                                        controller.myScanHistory[index]
                                                .generation! +
                                            " " +
                                            controller.myScanHistory[index].year
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: getWidth(13),
                                            color: const Color(0xffABABAB)),
                                      ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  DateTimeFormatExtension
                                      .displayTimeFromTimestampForPost(
                                          controller
                                              .myScanHistory[index].foundDate
                                              .toLocal()),
                                  style: TextStyle(
                                      fontSize: getWidth(12),
                                      color: const Color(0xff939598)),
                                ),
                              ],
                            ),
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
    );
  }

  carPicture(String url) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Image.network(
        otherImageUrl + url,
        errorBuilder: (BuildContext context,_,__){
          return Container(
            height: 60,
              width: 60,
              decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(8),
          ));
        },
        height: 60,
        width: 60,
        fit: BoxFit.cover,
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
