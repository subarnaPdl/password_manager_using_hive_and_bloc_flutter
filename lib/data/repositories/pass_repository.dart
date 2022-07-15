// ignore_for_file: invalid_null_aware_operator

import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/data/models/pass_model.dart';

class PassRepository {
  late Box<SuperPassModel> _passList;

  Future<void> init() async {
    Hive.registerAdapter(PassModelAdapter());
    _passList = await Hive.openBox<SuperPassModel>('pass');
    print("Hive Loaded");
  }

  Future<void> close() async {
    await Hive.close();
    print("Hive Closed");
  }

  // Fetch data
  Future<List<SuperPassModel>> getData() async {
    print("Fetch data called.");
    return _passList.values?.toList() ?? [];
  }

  // Store data
  Future<void> saveData(SuperPassModel pass) async {
    print("Store data called. Id = ${pass.id}");
    await _passList.add(pass);
  }

  // Delete data
  Future<void> deleteData(String id) async {
    print("Delete data called. Id = $id");

    SuperPassModel passToRemove =
        _passList.values.firstWhere((element) => element.id == id);
    await passToRemove.delete();
  }

  // Update data
  Future<void> updateData(String id, SuperPassModel pass) async {
    print("Update data called. Id = $id");
    final passToUpdate =
        _passList.values.firstWhere((element) => element.id == id);
    final index = passToUpdate.key as int; //index of pass to update
    await _passList.put(index, pass);
  }
}
