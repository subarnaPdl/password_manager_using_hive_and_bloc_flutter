// ignore_for_file: avoid_print

import 'package:password_manager/data/dataproviders/savepass.dart';

class AuthRepository {
  login({required String password}) async {
    print("Attempting Login");

    SecureStorageUtil _verify = SecureStorageUtil();
    // ignore: unrelated_type_equality_checks
    if (password == await _verify.getPass(key: "MasterPass")) {
      print("Logged in");
      return true;
    }

    throw Exception("Password Incorrect");
  }

  signup({required String password}) async {
    print("Attempting Signup");

    try {
      SecureStorageUtil _register = SecureStorageUtil();
      await _register.putPass(key: "MasterPass", value: password);
      print("Signup Success");
    } catch (e) {
      throw Exception("Failed to Signup");
    }
  }
}
