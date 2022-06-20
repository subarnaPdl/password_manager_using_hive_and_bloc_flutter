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
    print(
        "Fetch data called. Data : ${_passList.values.toList()[0].websiteName}");
    return _passList.values.toList();
  }

  // Store data
  Future<void> saveData(PassModel newPass) async {
    print(
        "Store data called. Data is \n WebsiteName : ${newPass.websiteName} \n Username : ${newPass.username} \n Password : ${newPass.password}");
    await _passList.add(newPass);
  }

  // Delete data
  Future<void> removeData({required String id}) async {
    print("Remove data called.");
    final passToRemove =
        _passList.values.firstWhere((element) => element.id == id);
    await _passList.delete(passToRemove);
  }

  // Update data
  Future<void> updateData(
      {required String id, required PassModel updatedPass}) async {
    print("Update data called.");
    final passToUpdate =
        _passList.values.firstWhere((element) => element.id == id);
    final index = passToUpdate.key as int; //index of pass to update
    await _passList.put(index, updatedPass);
  }
}
