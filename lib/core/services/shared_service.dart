import 'package:shared_preferences/shared_preferences.dart';

class MySharedService {
  final SharedPreferences prefs;

  MySharedService({required this.prefs});

  Future<bool> setLoginStatus(bool status) async {
    bool isDone = await prefs.setBool('login', status);
    return isDone;
  }

  Future<bool> setSharedUserId(String id) async {
    bool isDone = await prefs.setString('userID', id);
    return isDone;
  }

  Future<bool> setSharedFirstName(String name) async {
    bool isDone = await prefs.setString('firstName', name);
    return isDone;
  }

  Future<bool?> getLoginStatus() async {
    return prefs.getBool('login');
  }

  Future<String?> getSharedUserId() async {
    return prefs.getString('userID');
  }

  Future<String?> getSharedFirstName() async {
    return prefs.getString('firstName');
  }

  Future<void> removeSharedService() async {
    await prefs.clear();
  }
}
