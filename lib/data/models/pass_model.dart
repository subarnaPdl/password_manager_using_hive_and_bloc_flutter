class PassModel {
  final String websiteName;
  final String username;
  final String password;

  PassModel({
    required this.websiteName,
    required this.username,
    required this.password,
  });

  // factory PassModel.fromJson(Map<String, dynamic> json, String id) {
  //   return PassModel(
  //     websiteName: json['website'],
  //     username: json['username'],
  //     password: json['password'],
  //   );
  // }

  // Map<String, dynamic> tojson() {
  //   return {
  //     'websiteName': websiteName,
  //     'username': username,
  //     'password': password,
  //   };
  // }
}
