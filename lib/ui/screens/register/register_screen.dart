import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wtc/core/constant/app_asset.dart';
import 'package:wtc/core/constant/app_color.dart';
import 'package:wtc/core/constant/app_settings.dart';
import 'package:wtc/core/extension/custom_button_extension.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/core/utils/config.dart';
import 'package:wtc/ui/screens/login/login_screen.dart';
import 'package:wtc/ui/screens/register/controller/register_controller.dart';
import 'package:wtc/ui/screens/register/widget/register_username.dart';
import 'package:wtc/ui/shared/customAppTextfield.dart';
import 'package:wtc/ui/shared/custom_appbar.dart';
import 'package:wtc/ui/shared/custombutton.dart';
import 'package:wtc/ui/shared/image_background.dart';
import 'package:wtc/ui/screens/register/widget/privacy_police_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);
  static const String routeName = "/registerScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController registerController = Get.find<RegisterController>();
  bool confirmed = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disposeKeyboard();
      },
      child: Scaffold(
        body: ImageBackground(
          image: AppBackgrounds.splashBG,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                actionButtonType: ActionButtonType.textButton,
                pageNum: "1",
              ),
              Form(
                key: formKey,
                child: Expanded(
                  child: ListView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    children: [
                      SizedBox(
                        height: getHeight(15),
                      ),
                      Text(
                        "register_an_account".tr,
                        style: TextStyle(
                            fontSize: getWidth(34),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "enter_your_email".tr,
                        style: TextStyle(
                          fontSize: getWidth(16),
                          color: const Color(0xffABABAB),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      CustomAppTextField(
                        textFieldType: TextFieldType.emailType,
                        textInputAction: TextInputAction.next,
                        textEditingController: registerController.emailText,
                      ),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      CustomAppTextField(
                        textFieldType: TextFieldType.passwordType,
                        textEditingController: registerController.passwordText,
                      ),
                      SizedBox(
                        height: getHeight(10),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: confirmed,
                              fillColor: MaterialStateProperty.all(AppColor.kPrimaryBlue),
                              onChanged: (value) {
                                setState(() {
                                  confirmed = !confirmed;
                                });
                              }),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                showPrivacyPoliceDialog(context: context);
                              },
                              child:Text(
                              "conditions_acceptance".tr,
                              style: TextStyle(
                                  color:AppColor.kPrimaryBlue,
                                  decoration: TextDecoration.underline,
                                  fontSize: getWidth(16)),
                            ),
                          ),)
                        ],
                      ),
                       SizedBox(height: getHeight(10),),
                      CustomButton(
                          type: CustomButtonType.colourButton,
                          padding: kDefaultPadding,
                          text: "next".tr,
                          onTap: () {
                            disposeKeyboard();
                            if (formKey.currentState!.validate() && confirmed) {
                              formKey.currentState!.save();
                              Get.toNamed(RegisterUserNameScreen.routeName);
                            }
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
