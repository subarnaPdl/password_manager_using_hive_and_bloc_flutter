import 'package:hive/hive.dart';

class AuthRepository {
  late Box _masterPass;

  Future<void> init() async {
    _masterPass = await Hive.openBox('masterPassBox');
  }

  Future<void> close() async {
    await Hive.close();
  }

  Future<void> signup({required String password}) async {
    _masterPass.put("MasterPass", password);
  }

  Future<bool> login({required String password}) async {
    if (await _masterPass.get("MasterPass") == password) {
      return true;
    } else {
      return false;
    }
  }
}
