import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:wtc/core/service/repo/user_repo.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/ui/shared/loader.dart';

enum RequestApiType { get, post, delete }

class API {
  static late http.Response response;

  static Future apiHandler({
    required String url,
    RequestApiType requestType = RequestApiType.post,
    Map<String, String>? header,
    bool showLoader = true,
    bool showToast = true,
    dynamic body,
  }) async {
    try {
      if (await checkConnection()) {
        if (showLoader) LoadingOverlay.of().show();

        log("URl ===> $url");
        log("HEADER ===> $header");
        log("BODY ===> $body");
        if (requestType == RequestApiType.get) {
          response = await http.get(
            Uri.parse(url),
            headers: header,
          );
        } else if (requestType == RequestApiType.post) {
          response =
              await http.post(Uri.parse(url), headers: header, body: body);
        } else if (requestType == RequestApiType.delete) {
          response =
              await http.delete(Uri.parse(url), headers: header, body: body);
        }
        var responseDecode = jsonDecode(response.body);
        if (response.statusCode == 200) {
          log("RETURN RESPONSE BODY ===> $responseDecode");

          if (showLoader) LoadingOverlay.of().hide();

          return responseDecode;
        } else if (response.statusCode == 401) {
          if (showLoader) LoadingOverlay.of().hide();
          if (showToast) flutterToast(responseDecode["error"]["message"]);
        } else if (response.statusCode == 500 || response.statusCode == 409) {
          await UserRepo.userLogOut();
          if (showLoader) LoadingOverlay.of().hide();
          if (showToast) flutterToast(responseDecode["error"]["message"]);
        } else {
          if (showLoader) LoadingOverlay.of().hide();
          print("STATUS CODE IS NOT 200 $responseDecode");
          return null;
        }
      } else {
        flutterToast('check_your_connection'.tr);
        return null;
      }
    } catch (e) {
      print("ERROR FROM API CLASS $e");
    }
  }

  static Future multiPartAPIHandler(
      {List<File>? fileImage,
      Map<String, String>? field,
      File? thumbnail,
      bool showLoader = true,
      bool showToast = true,
      String multiPartImageKeyName = "image",
      Map<String, String>? header,
      required String url}) async {
    try {
      bool connection = await checkConnection();

      if (connection) {
        log("URl ===> $url");
        log("HEADER ===> $header");
        log("BODY ===> $field");

        if (showLoader) LoadingOverlay.of().show();
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(url),
        );

        if (header != null) request.headers.addAll(header);

        if (field != null) request.fields.addAll(field);

        if (fileImage != null) {
          fileImage.forEach((element) async {
            // String? mimeType = mime(element.path);
            // print(mimeType);
            request.files.add(await http.MultipartFile.fromPath(
              multiPartImageKeyName, element.path,

              /// if backend developer need particular type of image and video,so use as well
              // contentType: mimeee.MediaType(
              //     mimeType!.split("/")[0], mimeType.split("/")[1]),
            ));
          });
        }

        if (thumbnail != null) {
          request.files.add(await http.MultipartFile.fromPath(
              "thumbnailImage", thumbnail.path));
        }

        http.StreamedResponse res = await request.send();

        var response = await res.stream.bytesToString();
        var responseDecode = jsonDecode(response);
        if (res.statusCode == 200) {
          log("RETURN RESPONSE BODY ===> $responseDecode");

          if (showLoader) LoadingOverlay.of().hide();

          return responseDecode;
        } else if (res.statusCode == 401) {
          if (showLoader) LoadingOverlay.of().hide();
          if (showToast) flutterToast(responseDecode["error"]["message"]);
        } else if (res.statusCode == 500 || res.statusCode == 409) {
          await UserRepo.userLogOut();
          if (showLoader) LoadingOverlay.of().hide();
          if (showToast) flutterToast(responseDecode["error"]["message"]);
        } else {
          print("STATUS CODE IS NOT 200 $responseDecode");

          if (showLoader) LoadingOverlay.of().hide();

          return null;
        }
      } else {
        flutterToast('check_your_connection'.tr);
        return null;
      }
    } catch (e) {
      print("ERROR FROM API CLASS $e");
    }
  }
}
