// ignore_for_file: invalid_null_aware_operator

import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/data/models/pass_model.dart';

class PassRepository {
  late Box<SuperPassModel> _passList;

  Future<void> init() async {
    Hive.registerAdapter(SuperPassModelAdapter());
    Hive.registerAdapter(PassModelAdapter());
    _passList = await Hive.openBox<SuperPassModel>('password');
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
  Future<void> saveData(String title, PassModel passModel) async {
    print("Store data called. title = $title");

    if (!_passList.values.any((element) => element.title == title)) {
      await _passList.add(SuperPassModel(title: title, passModel: [passModel]));
    } else {
      print("executed");
      final pMs = _passList.values
          .firstWhere((element) => element.title == title)
          .passModel;
      pMs.add(passModel);

      final index =
          (_passList.values.firstWhere((element) => element.title == title)).key
              as int; //index of pass to modify

      await _passList.put(index, SuperPassModel(title: title, passModel: pMs));
    }

    print("pass saved");
  }

  // Delete data
  Future<void> deleteData(String title) async {
    print("Delete data called. title = $title");

    SuperPassModel passToRemove =
        _passList.values.firstWhere((element) => element.title == title);
    await passToRemove.delete();
  }

  // Update data
  Future<void> updateData(
      {required String title,
      required String username,
      required PassModel newPassModel}) async {
    print("Update data called. title = $title");
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
