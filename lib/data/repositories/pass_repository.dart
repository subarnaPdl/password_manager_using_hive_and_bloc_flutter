// ignore_for_file: invalid_null_aware_operator

import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/data/models/pass_model.dart';

class PassRepository {
  late Box<PassModel> _passList;

  Future<void> init() async {
    Hive.registerAdapter(PassModelAdapter());
    _passList = await Hive.openBox<PassModel>('pass');
    print("Hive Loaded");
  }

  Future<void> close() async {
    await Hive.close();
    print("Hive Closed");
  }

  // Fetch data
  Future<List<PassModel>> getData() async {
    print("Fetch data called.");
    // return [
    //   PassModel(
    //       id: "1",
    //       websiteName: "Facebook",
    //       username: "subarna",
    //       password: "password"),
    //   PassModel(
    //       id: "2",
    //       websiteName: "Instagram",
    //       username: "subarna",
    //       password: "password")
    // ];
    return _passList.values?.toList() ?? [];
  }

  // Store data
  Future<void> saveData(PassModel pass) async {
    print("Store data called. Id = ${pass.id}");
    await _passList.add(pass);
  }

  // Delete data
  Future<void> deleteData(String id) async {
    print("Delete data called. Id = $id");

    final passToRemove =
        _passList.values.firstWhere((element) => element.id == id);
    await _passList.delete(passToRemove);
  }

  // Update data
  Future<void> updateData(String id, PassModel pass) async {
    print("Update data called. Id = $id");
    final passToUpdate =
        _passList.values.firstWhere((element) => element.id == id);
    final index = passToUpdate.key as int; //index of pass to update
    await _passList.put(index, pass);
  }
}
