// ignore_for_file: invalid_null_aware_operator

import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/data/models/pass_model.dart';

class PassRepository {
  late Box<SuperPassModel> _passList;

  Future<void> init() async {
    Hive.registerAdapter(SuperPassModelAdapter());
    Hive.registerAdapter(PassModelAdapter());
    _passList = await Hive.openBox<SuperPassModel>('pass');
  }

  Future<void> close() async {
    await Hive.close();
  }

  // Fetch data
  Future<List<SuperPassModel>> getData() async {
    return _passList.values?.toList() ?? [];
  }

  // Store data
  Future<void> saveData(String title, PassModel passModel) async {
    // When adding for the first time
    if (!_passList.values.any((element) => element.title == title)) {
      await _passList.add(SuperPassModel(title: title, passModel: [passModel]));
    }

    // When title already exists
    else {
      final pMs = _passList.values
          .firstWhere((element) => element.title == title)
          .passModel;
      pMs.add(passModel);

      final index =
          (_passList.values.firstWhere((element) => element.title == title)).key
              as int; //index of pass to modify

      await _passList.put(index, SuperPassModel(title: title, passModel: pMs));
    }
  }

  // Delete data
  Future<void> deleteData({required String title, String? username}) async {
    SuperPassModel passToDelete =
        _passList.values.firstWhere((element) => element.title == title);
    // When delete title called
    if (username == null) {
      await passToDelete.delete();
    }

    // When delete username called
    else {
      var passModels = passToDelete.passModel;
      passModels.removeWhere((element) => element.username == username);

      final index =
          passToDelete.key as int; //index of pass to update after deleting
      await _passList.put(
          index, SuperPassModel(title: title, passModel: passModels));
    }
  }

  // Update data
  Future<void> updateData(
      {required String title,
      required String username,
      required PassModel newPassModel}) async {
    final passToUpdate =
        _passList.values.firstWhere((element) => element.title == title);
    final passModels = passToUpdate.passModel;
    final index = passModels.indexWhere((element) =>
        element.username == username); //index of username to update

    passModels[index] = newPassModel;

    final index2 = passToUpdate.key as int; //index of pass to update
    await _passList.put(
        index2, SuperPassModel(title: title, passModel: passModels));
  }
}
