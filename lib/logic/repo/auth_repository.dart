// ignore_for_file: avoid_print

class AuthRepository {
  Future login() async {
    print("Attempting Login");
    await Future.delayed(const Duration(seconds: 3));
    print("Logged in");
    throw Exception("Failed to Login");
  }
}
