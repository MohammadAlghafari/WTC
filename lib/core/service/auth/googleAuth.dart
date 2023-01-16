import 'package:google_sign_in/google_sign_in.dart';
import 'package:wtc/core/utils/app_function.dart';
import 'package:wtc/ui/shared/loader.dart';

class GoogleAuth {
  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    LoadingOverlay.of().show();
    GoogleSignIn _googleSignIn = GoogleSignIn();

    final v = await _googleSignIn.signIn();
    LoadingOverlay.of().hide();
    return v;
  }

  static Future<bool> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      return true;
    } catch (e) {
      flutterToast('Error signing out. Try again.');
    }
    return false;
  }
}
