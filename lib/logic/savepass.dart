import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtil {
  final FlutterSecureStorage _preferences = const FlutterSecureStorage();

  Future<String?> getPass({required String key}) {
    return _preferences.read(key: key);
  }

  Future<void> putPass({required String key, required String value}) {
    return _preferences.write(key: key, value: value);
  }

  Future<void> delPass(String key) {
    return _preferences.delete(key: key);
  }
}
