import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:wtc/core/utils/shared_prefrences.dart';
import 'package:wtc/ui/global.dart';
import 'package:wtc/ui/screens/landing/landing_screen.dart';
import 'package:wtc/ui/screens/login/model/wtc_user_model.dart';
import 'package:wtc/ui/screens/recent/model/search_history_model.dart';

import '../api_handler.dart';
import '../api_routes.dart';

class UserRepo {
  static Future userRegisterRepo({
    required String email,
    required String password,
    required String userName,
    List<File>? userPicture
  }) async {
    var responseBody = await API.multiPartAPIHandler(
        url: APIRoutes.register,
        field: {
          "username": userName,
          "email": email,
          "password": password,
          "c_password": password,
        },
        fileImage: userPicture,
        multiPartImageKeyName: "profile_img");
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }

  static Future userLoginRepo({
    required String email,
    required String password,
  }) async {
    try {
      var responseBody = await API.apiHandler(
          url: APIRoutes.userLogin,
          body: {"email": email, "password": password});

      if (responseBody != null) {
        return responseBody;
      } else {
        return null;
      }
    } on Exception catch (e) {}
  }

  static Future socialLoginRepo(
      {required String username,
      required String email,
      required String socialId,
      required SocialLoginProvider socialLoginProvider}) async {
    try {
      var responseBody =
          await API.apiHandler(url: APIRoutes.socialLogin, body: {
        "username": username,
        "email": email,
        "social_id": socialId,
        "provider": socialLoginProvider.name.capitalizeFirst
      });

      if (responseBody != null) {
        return responseBody;
      } else {
        return null;
      }
    } on Exception catch (e) {}
  }

  static Future userLogOut() async {
    try {
      var responseBody = await API.apiHandler(
          url: APIRoutes.logOut,
          showToast: false,
          header: {"Authorization": "Bearer " + userController.token});

      if (responseBody != null) {
        LocalDB.clearData();
        userController.wtcUserModel = WtcUserModel(success: Success());
        userController.guestLoginFlow = false;
        userController.guestAsFlow = true;
        userController.saveHistory = false;
        Get.offAllNamed(LandingScreen.routeName);
        return responseBody;
      } else {
        return null;
      }
    } on Exception catch (e) {}
  }

  static Future userDeleteAccount() async {
    try {
      var responseBody = await API.apiHandler(
          url: APIRoutes.deleteAccount,
          requestType: RequestApiType.delete,
          showToast: false,
          header: {"Authorization": "Bearer " + userController.token});

      if (responseBody != null) {
        LocalDB.clearData();
        userController.wtcUserModel = WtcUserModel(success: Success());
        userController.guestLoginFlow = false;
        userController.guestAsFlow = true;
        userController.saveHistory = false;
        Get.offAllNamed(LandingScreen.routeName);
        return responseBody;
      } else {
        return null;
      }
    } on Exception catch (e) {}
  }

  static Future forgotPasswordRepo({
    required String email,
  }) async {
    var responseBody = await API
        .apiHandler(url: APIRoutes.forgotPassword, body: {"email": email});
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }

  static Future changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    var responseBody =
        await API.apiHandler(url: APIRoutes.changePassword, header: {
      "Authorization": "Bearer " + userController.token
    }, body: {
      "old_password": currentPassword,
      "password": newPassword,
      "confirm_password": newPassword,
    });
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }

  static Future resetPassword({
    required String newPassword,
    required String email,
    required String token,
  }) async {
    var responseBody =
        await API.apiHandler(url: APIRoutes.resetPassword, body: {
      "token": token,
      "email": email,
      "password": newPassword,
      "password_confirmation": newPassword,
    });
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }

  static Future updateProfile({
    required String userName,
    required String firstName,
    required String lastName,
    required String email,
    required File? picture,
  }) async {
    var responseBody = await API.multiPartAPIHandler(
        url: APIRoutes.updateProfile,
        header: {
          "Authorization": "Bearer " + userController.token,
          'Accept': 'application/json',
        },
        multiPartImageKeyName: "profile_img",
        fileImage: picture == null ? null : [picture],
        field: {
          "username": userName,
          "lastname": lastName,
          "firstname": firstName,
          "email": email,
        });
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }

  static Future fetchUserHistoryRepo() async {
    var responseBody = await API.apiHandler(
        url: APIRoutes.userHistory,
        header: {"Authorization": "Bearer " + userController.token},
        requestType: RequestApiType.get);
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }

  static Future fetchUserNotification() async {
    var responseBody = await API.apiHandler(
        url: APIRoutes.notifications,
        header: {"Authorization": "Bearer " + userController.token},
        requestType: RequestApiType.get);
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }
  static Future otherUserHistoryRepo() async {
    var responseBody = await API.apiHandler(
        url: APIRoutes.otherUserHistory,
        header: {"Authorization": "Bearer " + userController.token},
        requestType: RequestApiType.get);
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }

  static Future saveHistory({
    required File file,
    required String makeName,
    required String modelName,
    required String generationName,
    required String color,
    required String year,
    bool showLoader = false,
    required String probability,
  }) async {
    var responseBody = await API.multiPartAPIHandler(
        url: APIRoutes.saveHistory + "/$makeName/$modelName",
        header: {"Authorization": "Bearer " + userController.token},
        multiPartImageKeyName: "car_img",
        showLoader: showLoader,
        showToast: false,
        fileImage: [file],
        field: {
          "probability": probability,
          "color": color,
          "year": year,
          "generation": generationName
        });
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }

  static Future removePicture() async {
    var responseBody = await API.apiHandler(
        url: APIRoutes.profileRemove,
        header: {"Authorization": "Bearer " + userController.token},
        body: jsonEncode({"profile_img": false}));
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }
}

enum SocialLoginProvider { google, facebook, apple }
