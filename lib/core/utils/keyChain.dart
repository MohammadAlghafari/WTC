import 'package:flutter_keychain/flutter_keychain.dart';

putKeyChain({required String? name, required String? email}) async {
  await FlutterKeychain.put(key: "com.wtc.app-email", value: email ?? "");
  await FlutterKeychain.put(key: "com.wtc.app-name", value: name ?? "");
}

Future<Map<String, dynamic>?> getKeyChain() async {
  var email = await FlutterKeychain.get(key: "com.wtc.app-email");
  var name = await FlutterKeychain.get(key: "com.wtc.app-email");
  if (email == null && name == null) {
    return null;
  } else {
    return {"name": name ?? "", "email": email ?? ""};
  }
}
