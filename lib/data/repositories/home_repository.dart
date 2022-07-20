import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeRepository {
  final _preferences = const FlutterSecureStorage();
  final key = "isFirstTime";

  Future<bool> get isFirstTime async =>
      !(await _preferences.read(key: key) == "false");

  Future<void> setFirstTimeAsFalse() async {
    await _preferences.write(key: key, value: "false");
  }
}
