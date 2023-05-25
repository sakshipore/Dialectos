import 'package:get/get.dart';

import 'package:dialectos/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:dialectos/locator.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(locator.get<AuthController>());
  }
}
