import 'package:hive/hive.dart';

part 'pass_model.g.dart';

@HiveType(typeId: 0)
class PassModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String notes;

  PassModel({
    required this.id,
    required this.title,
    required this.username,
    required this.password,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'websiteName': title,
      'username': username,
      'password': password,
      'notes': notes,
    };
  }

  factory PassModel.fromJson(Map<String, dynamic> json) {
    return PassModel(
      id: json['id'],
      title: json['website'],
      username: json['username'],
      password: json['password'],
      notes: json['notes'],
    );
  }
}
