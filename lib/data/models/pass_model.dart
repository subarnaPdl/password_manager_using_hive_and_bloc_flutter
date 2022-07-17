import 'package:hive/hive.dart';

part 'pass_model.g.dart';

@HiveType(typeId: 0)
class SuperPassModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<PassModel> passModel;

  SuperPassModel({
    required this.title,
    required this.passModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'websiteName': title,
      'passModel': passModel,
    };
  }

  factory SuperPassModel.fromJson(Map<String, dynamic> json) {
    return SuperPassModel(
      title: json['website'],
      passModel: json['passModel'],
    );
  }
}

@HiveType(typeId: 1)
class PassModel extends HiveObject {
  @HiveField(0)
  String username;
  @HiveField(1)
  String password;
  @HiveField(2)
  String notes;

  PassModel({
    this.username = '',
    this.password = '',
    this.notes = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'notes': notes,
    };
  }

  factory PassModel.fromJson(Map<String, dynamic> json) {
    return PassModel(
      username: json['username'],
      password: json['password'],
      notes: json['notes'],
    );
  }
}
