// ignore_for_file: avoid_print

class AuthRepository {
  Future login() async {
    print("Attempting Login");
    await Future.delayed(const Duration(seconds: 3));
    print("Logged in");
    throw Exception("Failed to Login");
  }

  Future signup() async {
    print("Attempting Signup");
    await Future.delayed(const Duration(seconds: 3));
    print("Signup Success");
    throw Exception("Failed to Signup");
  }
}
