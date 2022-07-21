import 'package:hive/hive.dart';

part 'trash_pass_model.g.dart';

@HiveType(typeId: 2)
class TrashSuperPassModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<TrashPassModel> passModel;

  TrashSuperPassModel({
    required this.title,
    required this.passModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'websiteName': title,
      'passModel': passModel,
    };
  }

  factory TrashSuperPassModel.fromJson(Map<String, dynamic> json) {
    return TrashSuperPassModel(
      title: json['website'],
      passModel: json['passModel'],
    );
  }
}

@HiveType(typeId: 3)
class TrashPassModel extends HiveObject {
  @HiveField(0)
  String username;
  @HiveField(1)
  String password;
  @HiveField(2)
  String notes;

  TrashPassModel({
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

  factory TrashPassModel.fromJson(Map<String, dynamic> json) {
    return TrashPassModel(
      username: json['username'],
      password: json['password'],
      notes: json['notes'],
    );
  }
}
