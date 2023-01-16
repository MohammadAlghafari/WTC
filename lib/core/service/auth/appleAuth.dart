import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/ui/shared/loader.dart';

class AppleAuth {
  static Future<AuthorizationCredentialAppleID> appleLogin() async {
    LoadingOverlay.of().show();
    return await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    ).catchError((e) async {
      LoadingOverlay.of().hide();
      flutterToast(e);
    }).then((credential) async {
      LoadingOverlay.of().hide();
      return credential;
    });
  }
}
