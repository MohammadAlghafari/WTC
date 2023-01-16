import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  ImagePicker imagePicker = ImagePicker();
  String? tag;
  late ImagePickerController _imagePickerController;
  ImagePickerController get imagePickerController =>
      Get.find<ImagePickerController>(tag: tag);

  AppImagePicker({String? tag}) {
    tag = tag;
    _imagePickerController = Get.put(ImagePickerController(), tag: tag);
    print("ImagePickerController.....");
  }

  browseImage(ImageSource source) async {
    try {
      var pickedFile =
          await imagePicker.pickImage(source: source, imageQuality: 50);
      if (pickedFile != null) {
        File? file = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: const AndroidUiSettings(
            toolbarColor: Colors.white,
            toolbarTitle: "Image Cropper",
          ),
        );
        imagePickerController.image = file;
      }
    } on PlatformException {
      // flutterToast(source == ImageSource.gallery
      //     ? "Allow access to photo library"
      //     : "Allow access to camera to capture photos");
    } catch (error) {
      // flutterToast(source == ImageSource.gallery
      //     ? "Allow access to photo library"
      //     : "Allow access to camera to capture photos");
    }
  }

  Future openBottomSheet() async {
    BuildContext context = Get.context as BuildContext;
    if (Platform.isIOS) {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: const Text(
                'Camera',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await browseImage(
                  ImageSource.camera,
                );

                Get.back();
              },
            ),
            CupertinoActionSheetAction(
              child: const Text(
                'Gallery',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await browseImage(
                  ImageSource.gallery,
                );

                Get.back();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      );
    } else {
      await Get.bottomSheet(
        SizedBox(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                tileColor: Colors.white,
                onTap: () async {
                  await browseImage(ImageSource.gallery);
                  Get.back();

                  /*
                  var status = await Permission.photos.status;
                  print("STATUS ${status}");
                  // try {
                  if (status == PermissionStatus.denied) {
                    print("DENIED");
                    askPermissionAgain(Permission.photos);
                  } else if (status == PermissionStatus.permanentlyDenied) {
                    await openAppSettings();
                  } else if (status == PermissionStatus.granted ||
                      status == PermissionStatus.limited) {
                    print("GRNATED");
                    browseImage(ImageSource.gallery);
                  } else {
                    showMessage("restrictedAccessMsg".tr);
                  }
                 */
                },
              ),
              const Divider(
                height: 0.5,
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                tileColor: Colors.white,
                onTap: () async {
                  await browseImage(
                    ImageSource.camera,
                  );
                  Get.back();
                },
              ),
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.3),
      );
    }
  }
}

class ImagePickerController extends GetxController {
  File? _image;

  setImage(String url) async {
    print("setImage ${url}");
    if (url != "") {
      _image = File(url);
      update();
    }
  }

  File? get image => _image;
  set image(File? value) {
    _image = value;
    // currentUser.pic = _image.path;
    // saveProfilePic();
    update();
  }

  reset() {
    image = null;
  }
}
