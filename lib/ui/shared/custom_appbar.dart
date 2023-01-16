import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/utils/config.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      this.pageNum,
      this.actionButtonClick,
      this.actionButtonType = ActionButtonType.none,
      this.leadingButtonClick,
      this.leadingButtonShow = true})
      : super(key: key);
  final String? pageNum;
  final Function()? actionButtonClick;
  final Function()? leadingButtonClick;
  final ActionButtonType actionButtonType;
  final bool leadingButtonShow;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 80,
        width: Get.width,
        // color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          children: [
            leadingButtonShow
                ? GestureDetector(
                    onTap: leadingButtonClick ??
                        () {
                          Get.back();
                        },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white12),
                      child: const Icon(Icons.arrow_back_sharp),
                    ),
                  )
                : SizedBox(),
            const Spacer(),
            GestureDetector(
                onTap: actionButtonClick,
                child: ActionButtonType.cancel == actionButtonType
                    ? actionButtons()
                    : Container(
                        color: Colors.transparent, child: actionButtons()))
          ],
        ),
      ),
    );
  }

  Widget actionButtons() {
    switch (actionButtonType) {
      case ActionButtonType.textButton:
        return Text(
          "$pageNum ${"of".tr} 2",
          style: TextStyle(fontSize: getWidth(18)),
        );
      case ActionButtonType.skip:
        return Text(
          "skip".tr,
          style: TextStyle(fontSize: getWidth(18)),
        );
      case ActionButtonType.done:
        return Text(
          "done".tr,
          style: TextStyle(fontSize: getWidth(18)),
        );
      case ActionButtonType.cancel:
        return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white12),
          child: const Icon(Icons.close),
        );
      case ActionButtonType.share:
        return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white12),
          child: const Icon(Icons.share),
        );
      case ActionButtonType.none:
        return const SizedBox();
    }
  }
}

enum ActionButtonType { textButton, skip, cancel, done, share, none }
