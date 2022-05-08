import 'package:password_manager/data/models/pass_model.dart';

class PassRepository {
  Future<List<PassModel>> getData() async {
    try {
      // final pass = await Amplify.DataStore.query(Pass.classType);
      // return pass;
      return [];
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveData(
      {required String websiteName,
      required String username,
      required String password}) async {
    final newPass = PassModel(
      websiteName: websiteName,
      username: username,
      password: password,
    );
    try {
      // await Amplify.DataStore.save(newPass);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateData(
      {required String websiteName,
      required String username,
      required String password}) async {
    final newPass = PassModel(
      websiteName: websiteName,
      username: username,
      password: password,
    );
    try {
      // await Amplify.DataStore.save(newPass);
    } catch (e) {
      throw e;
    }
  }
}
