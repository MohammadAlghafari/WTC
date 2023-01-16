import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/camera/controller/get_started_controller.dart';
import 'package:wtc/ui/screens/camera/controller/gallery_image_controller.dart';
import 'package:wtc/ui/screens/photo_preview/photo_preview_screen.dart';

Future<void> openImageBottomSheet() async {
  return showModalBottomSheet(
      context: Get.context as BuildContext,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (context) => ImageBottomSheet());
  // return showModalBottomSheet(
  //   context: Get.context as BuildContext,
  //   isScrollControlled: true,
  //   backgroundColor: Colors.transparent,
  //   builder: (context) {
  //     return GestureDetector(
  //       onTap: () => Navigator.of(context).pop(),
  //       child: Container(
  //         color: Color.fromRGBO(0, 0, 0, 0.001),
  //         child: GestureDetector(
  //           onTap: () {},
  //           child: DraggableScrollableSheet(
  //             initialChildSize: 1,
  //             minChildSize: 0.99,
  //             maxChildSize: 1,
  //             builder: (_, controller) {
  //
  //             },
  //           ),
  //         ),
  //       ),
  //     );
  //   },
  // );
}

class ImageBottomSheet extends StatelessWidget {
  const ImageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(Get.find<GetStartedController>()
                    .scaffoldKey
                    .currentState!
                    .context)
                .viewPadding
                .top),
        child: Column(
          children: [
            SizedBox(
              height: getHeight(30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: [
                  Text(
                    "camera_roll".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: getWidth(24)),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "cancel".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: getWidth(18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(20),
            ),
            Expanded(
              child: GetBuilder(
                builder: (GalleryImagePicker controller) => RefreshIndicator(
                  onRefresh: () async {
                    controller.fetchAssets();
                  },
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            // A grid view with 3 items per row
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.assets.length,
                    itemBuilder: (_, index) {
                      return AssetThumbnail(
                        assetEntity: controller.assets[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class AssetThumbnail extends StatelessWidget {
  final AssetEntity assetEntity;

  const AssetThumbnail({Key? key, required this.assetEntity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List?>(
      future: assetEntity.thumbnailData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;

        // If we have no data, display a spinner
        if (bytes == null) {
          return Container(
            color: Colors.grey,
          );
        }
        // If there's data, display it as an image
        return InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoPreviewScreen(
                    file: assetEntity.file,
                  ),
                ));
          },
          child: Image.memory(bytes, fit: BoxFit.cover),
        );
      },
    );
  }
}
