import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final _preferences = const FlutterSecureStorage();
  final key = "mpass";

  Future<bool> get isMasterPassCreated async =>
      await _preferences.containsKey(key: key);

  Future<void> signup({required String password}) async {
    await _preferences.write(key: key, value: password);
  }

  Future<bool> login({required String password}) async {
    if ((await _preferences.read(key: key)) == password) {
      return true;
    } else {
      return false;
    }
  }
}
