// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:wtc/core/constant/app_asset.dart';
// import 'package:wtc/core/constant/app_color.dart';
// import 'package:wtc/core/constant/app_settings.dart';
// import 'package:wtc/core/service/api_routes.dart';
// import 'package:wtc/core/utils/config.dart';
// import 'package:wtc/ui/screens/car_details/model/car_detail_model.dart';
// import 'package:wtc/ui/screens/car_details/model/custom_car_detal_model.dart';
// import 'package:wtc/ui/screens/photo_preview/model/tab_value_map.dart';
// import 'package:wtc/ui/screens/photo_preview/widget/car_found_screen.dart';
// import 'package:wtc/ui/shared/custom_appbar.dart';
//
// import '../car_detail_screen.dart';
// import 'custom_sliver_appbar.dart';
//
// class CarDetailScrollPortion extends StatefulWidget {
//   final CustomCarDetailModel customCarDetailModel;
//   const CarDetailScrollPortion({Key? key, required this.customCarDetailModel})
//       : super(key: key);
//
//   @override
//   State<CarDetailScrollPortion> createState() => _CarDetailScrollPortionState();
// }
//
// class _CarDetailScrollPortionState extends State<CarDetailScrollPortion>
//     with SingleTickerProviderStateMixin {
//   double scrollPercent = 0.0;
//   ScrollController scrollController = ScrollController();
//   final PageController pageController = PageController();
//   late TabController tabController;
//   @override
//   void initState() {
//     tabController = TabController(length: 5, vsync: this);
//     scrollController.addListener(() {
//       scrollPercent = scrollController.offset;
//       setState(() {});
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     scrollController.removeListener(() {});
//     scrollController.dispose();
//     pageController.dispose();
//     tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.customCarDetailModel.image != null &&
//             widget.customCarDetailModel.isFileImage
//         ? Hero(
//             tag: widget.customCarDetailModel.image!.path,
//             child: buildScaffold(widget.customCarDetailModel),
//           )
//         : buildScaffold(widget.customCarDetailModel);
//   }
//
//   Scaffold buildScaffold(CustomCarDetailModel customCarDetailModel) {
//     print(
//         " ------------------ second portion of Car detail --------------------");
//     return Scaffold(
//       body: Stack(
//         children: [
//           NestedScrollView(
//             controller: scrollController,
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return [
//                 SliverAppBar(
//                   pinned: true,
//                   stretch: true,
//                   expandedHeight: Get.height,
//                   collapsedHeight: Get.height * 0.30,
//                   backgroundColor: Colors.black,
//                   automaticallyImplyLeading: false,
//                   elevation: 0,
//                   flexibleSpace: Stack(
//                     fit: StackFit.expand,
//                     children: <Widget>[
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Expanded(
//                             child: customCarDetailModel.image != null
//                                 ? customCarDetailModel.isFileImage
//                                     ? Image.file(
//                                         File(customCarDetailModel.image!.path),
//                                         fit: BoxFit.cover,
//                                       )
//                                     : Image.network(
//                                         otherImageUrl +
//                                             customCarDetailModel.image,
//                                         fit: BoxFit.cover,
//                                       )
//                                 : Image.asset(
//                                     AppIcons.placeHolder,
//                                     fit: BoxFit.cover,
//                                   ),
//                           ),
//                           const SizedBox(
//                             height: 3,
//                           ),
//                         ],
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: ShaderMask(
//                           shaderCallback: (Rect bounds) => LinearGradient(
//                             colors: [
//                               Colors.transparent,
//                               Colors.transparent,
//                               Colors.black.withOpacity(0.50),
//                               Colors.black,
//                             ],
//                             end: Alignment.bottomCenter,
//                             begin: Alignment.topCenter,
//                           ).createShader(bounds),
//                           child: Container(
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: scrollPercent > getHeight(450) ? 20 : 50,
//                         left: scrollPercent > getHeight(450) ? 25 : 0,
//                         right: scrollPercent > getHeight(450) ? null : 0,
//                         child: Column(
//                           crossAxisAlignment: scrollPercent > getHeight(450)
//                               ? CrossAxisAlignment.start
//                               : CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               scrollPercent > getHeight(450)
//                                   ? "car_detail".tr
//                                   : "car_detected".tr,
//                               style: TextStyle(
//                                   fontSize: getWidth(13),
//                                   fontWeight: FontWeight.w500,
//                                   color: const Color(0xff939598)),
//                             ),
//                             SizedBox(
//                               height: getHeight(7),
//                             ),
//                             Text(
//                               customCarDetailModel.makeName,
//                               style: TextStyle(
//                                   fontSize: getWidth(34),
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             Text(
//                               customCarDetailModel.probability != null
//                                   ? customCarDetailModel.isFileImage
//                                       ? "${NumberFormat.percentPattern().format(customCarDetailModel.probability)} ${"probability".tr}"
//                                       : "${customCarDetailModel.probability}% ${"probability".tr}"
//                                   : "",
//                               style: TextStyle(
//                                 fontSize: getWidth(16),
//                                 color: const Color(0xff28A745),
//                               ),
//                             ),
//                             SizedBox(
//                               height: getHeight(20),
//                             ),
//                             scrollPercent > getHeight(100)
//                                 ? const SizedBox()
//                                 : const Icon(Icons.keyboard_arrow_down),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SliverPersistentHeader(
//                   delegate: MySliverPersistentHeaderDelegate(
//                       buildTabBar(customCarDetailModel)),
//                   pinned: true,
//                 ),
//               ];
//             },
//             body: PageView(
//               controller: pageController,
//               onPageChanged: (val) {
//                 scrollController.jumpTo((Get.height * 0.7));
//                 tabController.index = val;
//               },
//               children: [
//                 for (String key in carTabData.keys)
//                   buildTabBody(carTabData[key]!, customCarDetailModel)
//               ],
//             ),
//           ),
//           const CustomAppBar()
//         ],
//       ),
//     );
//   }
//
//   buildTabBar(CustomCarDetailModel customCarDetailModel) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//           child: Row(
//             children: [
//               Expanded(
//                 child: titleOrSubtitle(
//                     title: "color".tr,
//                     subTitle: customCarDetailModel.color ?? "-"),
//               ),
//               Expanded(
//                 child: titleOrSubtitle(
//                     title: "model".tr,
//                     subTitle: customCarDetailModel.modelName),
//               )
//             ],
//           ),
//         ),
//         const Spacer(),
//         TabBar(
//             isScrollable: true,
//             onTap: (val) {
//               scrollController.jumpTo((Get.height * 0.7));
//               pageController.jumpToPage(val);
//             },
//             controller: tabController,
//             physics: const BouncingScrollPhysics(),
//             unselectedLabelColor: Colors.white.withOpacity(0.30),
//             labelColor: AppColor.kPrimaryBlue,
//             indicatorSize: TabBarIndicatorSize.label,
//             // padding: EdgeInsets.only(right: getWidth(50)),
//             labelStyle: TextStyle(fontSize: getWidth(16)),
//             indicatorColor: AppColor.kPrimaryBlue,
//             tabs: [
//               for (String key in carTabData.keys)
//                 Tab(
//                   text: key,
//                 )
//             ])
//       ],
//     );
//   }
//
//   buildTabBody(
//       Map<String, dynamic> map, CustomCarDetailModel customCarDetailModel) {
//     return ListView(
//       physics: const ClampingScrollPhysics(),
//       padding: const EdgeInsets.only(top: 20),
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               for (String key in map.keys)
//                 Container(
//                   decoration: const BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(color: Colors.grey, width: 1))),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           key,
//                           style: TextStyle(
//                               color: const Color(0xff939598),
//                               fontWeight: FontWeight.w500,
//                               fontSize: getWidth(16)),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Text(
//                           map[key],
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: getWidth(16)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               SizedBox(
//                 height: getHeight(40),
//               ),
//               Text(
//                 "other_cars".tr,
//                 style: TextStyle(
//                     fontSize: getWidth(20), fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: getHeight(20),
//               ),
//             ],
//           ),
//         ),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.only(left: kDefaultPadding),
//           // clipBehavior: Clip.none,
//           child: Row(
//             children: customCarDetailModel.otherCarList
//                 .map((e) => GestureDetector(
//                       onTap: () async {
//                         Get.toNamed(CarDetailScreen.routeName,
//                             preventDuplicates: false,
//                             arguments: CarDetailModel(
//                               makeName: e.makeName,
//                               modelName: e.modelName,
//                             ));
//                       },
//                       child: Container(
//                         height: getWidth(80),
//                         width: getWidth(150),
//                         margin: const EdgeInsets.only(right: 10),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: const Color(0xff3b3b43),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               e.makeName,
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: getWidth(16)),
//                             ),
//                             Text(
//                               e.modelName,
//                               style: TextStyle(
//                                   color: const Color(0xffABABAB),
//                                   fontSize: getWidth(14)),
//                             )
//                           ],
//                         ),
//                       ),
//                     ))
//                 .toList(),
//           ),
//         ),
//         SizedBox(
//           height: getHeight(30),
//         ),
//       ],
//     );
//   }
// }
