import 'dart:developer';

import 'package:dialectos/routes/routes_names.dart';
import 'package:dialectos/services/firebase_service.dart';
import 'package:dialectos/services/shared_service.dart';
import 'package:dialectos/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final MySharedService _sharedService;
  final FirebaseService _firebaseService;
  bool isLoading = false;

  AuthController(MySharedService sharedService, FirebaseService firebaseService)
      : _sharedService = sharedService,
        _firebaseService = firebaseService;

  Future<void> login() async {
    try {
      isLoading = true;
      update();
      User? user = await _firebaseService.signInWithGoogle();
      if (user == null) throw "Something went wrong";
      await setUserData(true, user.displayName!, user.uid);
      Get.offAllNamed(RoutesNames.homeScreen);
    } catch (e) {
      log(e.toString());
      showSnackBar(
        "OOPS!!!",
        "Something went wrong",
        isError: true,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> logout() async {
    try {
      isLoading = true;
      update();
      await _firebaseService.signOut();
      await _sharedService.removeSharedService();
      Get.offAllNamed(RoutesNames.loginScreen);
    } catch (e) {
      log(e.toString());
      showSnackBar(
        "OOPS!!!",
        "Something went wrong",
        isError: true,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> setUserData(bool status, String name, String userID) async {
    try {
      await _sharedService.setLoginStatus(status);
      await _sharedService.setSharedFirstName(name);
      await _sharedService.setSharedUserId(userID);
    } catch (e) {
      log("Error in Shared Server : $e");
    }
  }
}
