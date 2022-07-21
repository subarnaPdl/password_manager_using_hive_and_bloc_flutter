// ignore_for_file: invalid_null_aware_operator

import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_manager/data/models/pass_model.dart';
import 'package:password_manager/data/models/trash_pass_model.dart';

class PassRepository {
  late Box<SuperPassModel> _passList;
  late Box<TrashSuperPassModel> _trashList;

  Future<void> init() async {
    // passList Hive box
    Hive.registerAdapter(SuperPassModelAdapter());
    Hive.registerAdapter(PassModelAdapter());
    _passList = await Hive.openBox<SuperPassModel>('pass');

    // trashList Hive box
    Hive.registerAdapter(TrashSuperPassModelAdapter());
    Hive.registerAdapter(TrashPassModelAdapter());
    _trashList = await Hive.openBox<TrashSuperPassModel>('trash1');
  }

  Future<void> close() async {
    await Hive.close();
  }

  // Fetch data
  Future<List<SuperPassModel>> getData() async {
    return _passList.values?.toList() ?? [];
  }

  // Fetch data
  Future<List<TrashSuperPassModel>> getTrashData() async {
    return _trashList.values?.toList() ?? [];
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

    TrashSuperPassModel passToAdd = TrashSuperPassModel(
      title: passToDelete.title,
      passModel: passToDelete.passModel
          .map((e) => TrashPassModel(
              username: e.username, password: e.password, notes: e.notes))
          .toList(),
    );

    // When delete title called
    if (username == null) {
      // Add to trashList

      // When title does not exist in trash
      if (!_trashList.values.any((element) => element.title == title)) {
        print("Delete title, title doesn't exist in trash");
        await _trashList.add(passToAdd);
      }

      // When title exists in trash
      else {
        print("Delete title, title exists in trash");
        var pMs = _trashList.values
            .firstWhere((element) => element.title == title)
            .passModel;

        pMs.addAll(passToAdd.passModel); // add deleted passlist with trashlist

        final index =
            (_trashList.values.firstWhere((element) => element.title == title))
                .key as int; //index of pass to modify

        await _trashList.put(
            index, TrashSuperPassModel(title: title, passModel: pMs));
      }

      // Delete from passList
      await passToDelete.delete();
    }

    // When delete username called
    else {
      // Add to trashList

      // When title doesnot exist in trash
      if (!_trashList.values.any((element) => element.title == title)) {
        print("Delete username, title doesn't exist in trash");

        final passModel = passToAdd.passModel
            .where((element) => element.username == username)
            .toList();

        int i = 1;
        print("pMs List:");
        for (var element in passModel) {
          print("$i. ${element.username}");
          i++;
        }

        await _trashList
            .add(TrashSuperPassModel(title: title, passModel: passModel));
      }

      // When title exists in trash
      else {
        print("Delete username, title exists in trash");
        var pMs = _trashList.values
            .firstWhere((element) => element.title == title)
            .passModel;
        pMs.add(passToAdd.passModel
            .firstWhere((element) => element.username == username));

        final index =
            (_trashList.values.firstWhere((element) => element.title == title))
                .key as int; //index of pass to modify

        await _trashList.put(
            index, TrashSuperPassModel(title: title, passModel: pMs));
      }

      // Delete from passList
      var passModels = passToDelete.passModel;
      passModels.removeWhere((element) => element.username == username);

      final index2 =
          passToDelete.key as int; //index of pass to update after deleting
      await _passList.put(
          index2, SuperPassModel(title: title, passModel: passModels));
    }
  }

  // Delete data from trash
  Future<void> deleteTrashData({required String title}) async {
    TrashSuperPassModel passToDelete =
        _trashList.values.firstWhere((element) => element.title == title);

    await passToDelete.delete();
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

  Future<void> recoverData({required String title}) async {
    // Add to passList
    final _deletedPassModels = _trashList.values
        .firstWhere((element) => element.title == title)
        .passModel;
    for (var pm in _deletedPassModels) {
      await saveData(
          title,
          PassModel(
            username: pm.username,
            password: pm.password,
            notes: pm.notes,
          ));
    }

    // Delete from trashList
    await deleteTrashData(title: title);
  }
}
