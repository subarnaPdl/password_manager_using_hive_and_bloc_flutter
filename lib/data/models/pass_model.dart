import 'package:hive/hive.dart';

part 'pass_model.g.dart';

@HiveType(typeId: 0)
class PassModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String websiteName;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;

  PassModel({
    required this.id,
    required this.websiteName,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'websiteName': websiteName,
      'username': username,
      'password': password,
    };
  }

  factory PassModel.fromJson(Map<String, dynamic> json) {
    return PassModel(
      id: json['id'],
      websiteName: json['website'],
      username: json['username'],
      password: json['password'],
    );
  }
}
