import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wtc/core/constant/app_color.dart';
import 'package:get/get.dart';

class CustomAppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextFieldType textFieldType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  const CustomAppTextField(
      {Key? key,
      required this.textEditingController,
      required this.textFieldType,
      this.validator,
      this.textInputAction = TextInputAction.done})
      : super(key: key);

  @override
  State<CustomAppTextField> createState() => _CustomAppTextFieldState();
}

class _CustomAppTextFieldState extends State<CustomAppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_onFocusChange);

    _focusNode.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 58,
          decoration: BoxDecoration(
            color: AppColor.kFieldFillColor,
            borderRadius: BorderRadius.circular(10),
            border: isFocused
                ? Border.all(color: AppColor.kPrimaryBlue)
                : const Border(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            cursorColor: Colors.white,
            controller: widget.textEditingController,
            obscureText: getObSecureText(),
            focusNode: _focusNode,
            validator: getValidation(),
            keyboardType: getKeyboardType(),
            inputFormatters: inputFormatter,
            textCapitalization: getTextCapitalization(),
            textInputAction: widget.textInputAction,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                label: Text(
                  getLabelText(),
                  style: TextStyle(
                      color: isFocused
                          ? AppColor.kPrimaryBlue
                          : const Color(0xff939598)),
                ),
                labelStyle: TextStyle(
                  color: isFocused
                      ? AppColor.kPrimaryBlue
                      : const Color(0xff939598),
                ),
                border: InputBorder.none),
          ),
        )
      ],
    );
  }

  List<TextInputFormatter>? get inputFormatter {
    switch (widget.textFieldType) {
      case TextFieldType.emailType:
      case TextFieldType.passwordType:
      case TextFieldType.confirmNewPassword:
      case TextFieldType.newPassword:
        return [FilteringTextInputFormatter.deny(RegExp('[ ]'))];
      default:
        return null;
    }
  }

  bool getObSecureText() {
    switch (widget.textFieldType) {
      case TextFieldType.currentPassword:
      case TextFieldType.confirmNewPassword:
      case TextFieldType.newPassword:
      case TextFieldType.passwordType:
        return true;
      default:
        return false;
    }
  }

  String getLabelText() {
    switch (widget.textFieldType) {
      case TextFieldType.passwordType:
        return "password".tr;
      case TextFieldType.emailType:
        return "email".tr;
      case TextFieldType.userName:
        return "username".tr;
      case TextFieldType.firstName:
        return "first_name".tr;
      case TextFieldType.lastName:
        return "last_name".tr;
      case TextFieldType.currentPassword:
        return "current_password".tr;
      case TextFieldType.newPassword:
        return "new_password".tr;
      case TextFieldType.confirmNewPassword:
        return "confirm_new_password".tr;
      default:
        return "";
    }
  }

  TextInputType getKeyboardType() {
    switch (widget.textFieldType) {
      case TextFieldType.confirmNewPassword:
      case TextFieldType.currentPassword:
      case TextFieldType.newPassword:
      case TextFieldType.passwordType:
        return TextInputType.visiblePassword;
      case TextFieldType.emailType:
        return TextInputType.emailAddress;
      case TextFieldType.userName:
        return TextInputType.name;
      case TextFieldType.firstName:
        return TextInputType.name;
      case TextFieldType.lastName:
        return TextInputType.name;
    }
  }

  TextCapitalization getTextCapitalization() {
    switch (widget.textFieldType) {
      case TextFieldType.userName:
        return TextCapitalization.sentences;
      case TextFieldType.firstName:
        return TextCapitalization.sentences;
      case TextFieldType.lastName:
        return TextCapitalization.sentences;
      default:
        return TextCapitalization.none;
    }
  }

  getValidation() {
    switch (widget.textFieldType) {
      case TextFieldType.userName:
        return (val) => val!.trim().isEmpty ? "please_enter_name".tr : null;
      case TextFieldType.confirmNewPassword:
        return widget.validator;
      case TextFieldType.passwordType:

      case TextFieldType.currentPassword:
      case TextFieldType.newPassword:
        return (val) => val!.trim().isEmpty ? "please_enter_password".tr : null;
      case TextFieldType.emailType:
        return (val) => val!.trim().isEmpty
            ? "please_enter_email".tr
            : RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                    .hasMatch(val)
                ? null
                : 'invalid_email'.tr;
      case TextFieldType.firstName:
        return (val) =>
            val!.trim().isEmpty ? "please_enter_firstname".tr : null;
      case TextFieldType.lastName:
        return (val) => val!.trim().isEmpty ? "please_enter_lastname".tr : null;
      default:
        return null;
    }
  }
}

enum TextFieldType {
  emailType,
  passwordType,
  userName,
  firstName,
  lastName,
  currentPassword,
  newPassword,
  confirmNewPassword,
}
