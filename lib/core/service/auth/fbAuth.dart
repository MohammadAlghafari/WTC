import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/ui/shared/loader.dart';

class FBAuth {
  static Future fbLogin() async {
    LoadingOverlay.of().show();
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email', 'pages_show_list', 'pages_messaging', 'pages_manage_metadata'],
    );
    print("fbLogin status ${result.status}");
    if (result.status == LoginStatus.success) {
      Map<String, dynamic> userData = await FacebookAuth.instance.getUserData();
      print("fbLogin USER $userData");
      return userData;
    } else {
      LoadingOverlay.of().hide();
      flutterToast(result.message ?? "Error while logging in FB");
      print("fbLogin message ${result.message}");
    }
  }

  static Future<bool> signOut() async {
    try {
      await FacebookAuth.instance.logOut();
      return true;
    } catch (e) {
      flutterToast('Error signing out. Try again.');
    }
    return false;
  }
}
