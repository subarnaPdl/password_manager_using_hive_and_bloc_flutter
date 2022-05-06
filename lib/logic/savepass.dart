import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtil {
  final FlutterSecureStorage _preferences = const FlutterSecureStorage();

  Future<String?> getPass() {
    return _preferences.read(key: "Pass");
  }

  Future<void> putPass(String value) {
    return _preferences.write(key: "Pass", value: value);
  }

  // Future<void> delPass(String key) {
  //   return _preferences.delete(key: key);
  // }

  // String? _getAccountName() =>
  //     _accountNameController.text.isEmpty ? null : _accountNameController.text;
}
