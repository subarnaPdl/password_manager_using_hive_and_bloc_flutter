class PassModel {
  final String id;
  final String website;
  final String password;

  PassModel({
    required this.id,
    required this.website,
    required this.password,
  });

  factory PassModel.fromJson(Map<String, dynamic> json, String id) {
    return PassModel(
      id: id,
      website: json['website'],
      password: json['password'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'website': website,
      'password': password,
    };
  }
}
