import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_color.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/service/api_routes.dart';
import 'package:wtc/core/service/repo/car_ai_repo.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/car_details/controller/car_detail_controller.dart';
import 'package:wtc/ui/screens/car_details/model/car_detail_model.dart';
import 'package:wtc/ui/screens/car_details/widget/custom_sliver_appbar.dart';
import 'package:wtc/ui/screens/photo_preview/controller/photo_preview_controller.dart';
import 'package:wtc/ui/screens/photo_preview/model/car_feature_model.dart';
import 'package:wtc/ui/screens/photo_preview/model/tab_value_map.dart';
import 'package:wtc/ui/screens/photo_preview/widget/car_found_screen.dart';
import 'package:wtc/ui/shared/aleartDialog.dart';
import 'package:wtc/ui/shared/custom_appbar.dart';

import '../../shared/share_dialog.dart';
import 'model/custom_car_detal_model.dart';

class CarDetailScreen extends StatefulWidget {
  static const String routeName = "/carDetailScreen";

  const CarDetailScreen({Key? key}) : super(key: key);

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late CarDetailController carDetailController;
  String? tag = DateTime.now().toIso8601String();
  Timer? timer;
  bool? dialogShow;
  @override
  void initState() {
    // String tag = Get.arguments.modelName as String;
    carDetailController = Get.put(CarDetailController(tag: tag), tag: tag);
    tabController = TabController(length: 5, vsync: this);
    timer = Timer(const Duration(seconds: 10), () {
      if (carDetailController.customCarDetailModel.id != null) {
        showCustomDialog(
            context: context, id: carDetailController.customCarDetailModel.id!);
        timer!.cancel();
      }
    });
    super.initState();
  }

  final PageController pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    tabController.dispose();
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      tag: tag,
      builder: (CarDetailController controller) {
        if (controller.customCarDetailModel.image != null &&
            controller.customCarDetailModel.isFileImage) {
          return Hero(
            tag: controller.customCarDetailModel.image!.path,
            child: buildScaffold(controller),
          );
        } else {
          return buildScaffold(controller);
        }
      },
    );
  }

  Scaffold buildScaffold(CarDetailController controller) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            controller: controller.scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  stretch: true,
                  expandedHeight: Get.height,
                  collapsedHeight: Get.height * 0.30,
                  backgroundColor: Colors.black,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  flexibleSpace: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: controller.customCarDetailModel.image != null
                                ? controller.customCarDetailModel.isFileImage
                                    ? Image.file(
                                        File(controller
                                            .customCarDetailModel.image!.path),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        otherImageUrl +
                                            controller
                                                .customCarDetailModel.image,
                                        fit: BoxFit.cover,
                                      )
                                : Image.asset(
                                    AppIcons.placeHolder,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) => LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black.withOpacity(0.50),
                              Colors.black,
                            ],
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                          ).createShader(bounds),
                          child: Container(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom:
                            controller.scrollPercent > getHeight(450) ? 20 : 50,
                        left:
                            controller.scrollPercent > getHeight(450) ? 25 : 0,
                        right: controller.scrollPercent > getHeight(450)
                            ? null
                            : 0,
                        child: Column(
                          crossAxisAlignment:
                              controller.scrollPercent > getHeight(450)
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.scrollPercent > getHeight(450)
                                  ? "car_detail".tr
                                  : "car_detected".tr,
                              style: TextStyle(
                                  fontSize: getWidth(13),
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff939598)),
                            ),
                            SizedBox(
                              height: getHeight(7),
                            ),
                            Text(
                              controller.customCarDetailModel.makeName,
                              style: TextStyle(
                                  fontSize: getWidth(34),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              controller.customCarDetailModel.probability !=
                                      null
                                  ? controller.customCarDetailModel.isFileImage
                                      // ? "${NumberFormat.percentPattern().format(controller.customCarDetailModel.probability)} ${"probability".tr}"
                                      ? "${(controller.customCarDetailModel.probability ?? 0) * 100}% ${"probability".tr}"
                                      : "${controller.customCarDetailModel.probability}% ${"probability".tr}"
                                  : "",
                              style: TextStyle(
                                fontSize: getWidth(16),
                                color: const Color(0xff28A745),
                              ),
                            ),
                            SizedBox(
                              height: getHeight(20),
                            ),
                            controller.scrollPercent > getHeight(100)
                                ? const SizedBox()
                                : const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: MySliverPersistentHeaderDelegate(buildTabBar()),
                  pinned: true,
                ),
              ];
            },
            body: PageView(
              controller: pageController,
              onPageChanged: (val) {
                controller.scrollController.jumpTo((Get.height * 0.7));
                tabController.index = val;
              },
              children: [
                for (String key
                    in carDetailController.customCarDetailModel.catTabData.keys)
                  buildTabBody(
                      carDetailController.customCarDetailModel.catTabData[key]!)
              ],
            ),
          ),
          CustomAppBar(
            actionButtonType: ActionButtonType.share,
            actionButtonClick: () async {
              carDetailController.shareCarDetail();
              /*  var url = await carDetailController.getShareUrl();
              showShareDialog(
                  context: context,
                  url: url,
                  shareFunction: carDetailController.shareCarDetail); */
            },
          )
        ],
      ),
    );
  }

  buildTabBar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            children: [
              Expanded(
                child: titleOrSubtitle(
                    title: "color".tr,
                    subTitle:
                        carDetailController.customCarDetailModel.color ?? "-"),
              ),
              Expanded(
                  child: titleOrSubtitle(
                title: "model".tr,
                subTitle: carDetailController.customCarDetailModel.modelName +
                    " " +
                    (carDetailController.customCarDetailModel.year ?? ""),
              ))
            ],
          ),
        ),
        const Spacer(),
        GetBuilder(
          tag: tag,
          builder: (CarDetailController controller) => TabBar(
              isScrollable: true,
              onTap: (val) {
                controller.scrollController.jumpTo((Get.height * 0.7));
                pageController.jumpToPage(val);
              },
              controller: tabController,
              physics: const BouncingScrollPhysics(),
              unselectedLabelColor: Colors.white.withOpacity(0.30),
              labelColor: AppColor.kPrimaryBlue,
              indicatorSize: TabBarIndicatorSize.label,
              // padding: EdgeInsets.only(right: getWidth(50)),
              labelStyle: TextStyle(fontSize: getWidth(16)),
              indicatorColor: AppColor.kPrimaryBlue,
              tabs: [
                for (String key
                    in carDetailController.customCarDetailModel.catTabData.keys)
                  Tab(
                    text: key,
                  )
              ]),
        ),
      ],
    );
  }

  buildTabBody(Map<String, dynamic> map) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(top: 20),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (String key in map.keys)
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          key,
                          style: TextStyle(
                              color: const Color(0xff939598),
                              fontWeight: FontWeight.w500,
                              fontSize: getWidth(16)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          map[key],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: getWidth(16)),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: getHeight(40),
              ),
              Text(
                "other_cars".tr,
                style: TextStyle(
                    fontSize: getWidth(20), fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: getHeight(20),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: kDefaultPadding),
          // clipBehavior: Clip.none,
          child: Row(
            children: carDetailController.customCarDetailModel.otherCarList
                .map((e) => GestureDetector(
                      onTap: () {
                        timer!.cancel();
                        carDetailController.fetchOtherCarData(e);
                      },
                      child: Container(
                        height: getWidth(80),
                        width: getWidth(150),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xff3b3b43),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.makeName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: getWidth(16)),
                            ),
                            Text(
                              e.modelName,
                              style: TextStyle(
                                  color: const Color(0xffABABAB),
                                  fontSize: getWidth(14)),
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        SizedBox(
          height: getHeight(30),
        ),
      ],
    );
  }
}
