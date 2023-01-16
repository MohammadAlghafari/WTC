import 'package:flutter/material.dart';
import 'package:wtc/core/constant/app_color.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/shared/custombutton.dart';

enum CustomButtonType {
  colourButton,
  borderButton,
}

extension CustomButtonExtension on CustomButtonType {
  ButtonProps get props {
    switch (this) {
      case CustomButtonType.colourButton:
        return ButtonProps(
            height: 50,
            radius: 8,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: getWidth(18),
              fontWeight: FontWeight.w500,
            ),
            backgroundColor: Colors.white,
            linearGradient: AppColor.customButtonGradient);

      case CustomButtonType.borderButton:
        return ButtonProps(
          height: 50,
          radius: 8,
          border: Border.all(color: Colors.white, width: 1),
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: getWidth(18),
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Colors.transparent,
        );
    }
  }
}
