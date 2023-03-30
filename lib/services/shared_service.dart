import 'package:shared_preferences/shared_preferences.dart';

class MySharedService {
  Future<bool> setLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    bool isDone = await prefs.setBool('login', status);
    return isDone;
  }

  Future<bool> setSharedUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    bool isDone = await prefs.setString('userID', id);
    return isDone;
  }

  Future<bool> setSharedFirstName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    bool isDone = await prefs.setString('firstName', name);
    return isDone;
  }

  Future<bool?> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('login');
  }

  Future<String?> getSharedUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userID');
  }

  Future<String?> getSharedFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('firstName');
  }

  Future<void> removeSharedService() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
