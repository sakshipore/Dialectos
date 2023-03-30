import 'package:dialectos/controllers/auth_controller.dart';
import 'package:dialectos/services/firebase_service.dart';
import 'package:dialectos/services/shared_service.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(MySharedService(), FirebaseService()));
  }
}
