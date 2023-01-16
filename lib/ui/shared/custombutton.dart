import 'package:flutter/material.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';

class ButtonProps {
  double height;
  double radius;
  TextStyle textStyle;
  BoxBorder? border;
  Color backgroundColor;
  LinearGradient? linearGradient;
  ButtonProps({
    required this.height,
    required this.radius,
    this.linearGradient,
    required this.textStyle,
    required this.backgroundColor,
    this.border,
  });
}

class CustomButton extends StatefulWidget {
  final CustomButtonType type;
  final String? text;
  final Function()? onTap;
  final double width;
  final ButtonProps props;
  final double padding;
  final Widget? customizableChild;

  CustomButton(
      {required this.type,
      this.text,
      required this.onTap,
      this.width = 0,
      props,
      this.padding = 0,
      this.customizableChild})
      : props = props ?? type.props;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: widget.padding),
        width: widget.width == 0 ? double.infinity : widget.width,
        height: widget.props.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.props.radius),
            ),
            gradient: widget.props.linearGradient,
            color: widget.props.backgroundColor,
            border: widget.props.border),
        alignment: Alignment.center,
        child: widget.customizableChild ??
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(widget.text!, style: widget.props.textStyle),
            ),
      ),
      // ),
    );
  }
}
