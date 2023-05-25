import 'dart:developer';

import 'package:dialectos/core/usecase/base_usecase.dart';
import 'package:dialectos/core/utilities/utilitiy_methods.dart';
import 'package:dialectos/features/authentication/domain/entities/user_entitiy.dart';
import 'package:dialectos/features/authentication/domain/usecases/login_usecase.dart';
import 'package:dialectos/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:dialectos/routes/routes_names.dart';
import 'package:dialectos/core/widgets/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final LoginUseCase login;
  final LogOutUseCase logout;
  UserEntity? user;

  AuthController({
    required this.login,
    required this.logout,
  });

  bool isLoading = false;

  Future<void> signIn() async {
    isLoading = true;
    update();

    try {
      final result = await login(NoParams());
      log("Inside controller");
      result.fold(
        (l) {
          showSnackBar(
            "OOPS!!!",
            getStringByFailure(l),
            isError: true,
          );
          isLoading = false;
          update();
        },
        (r) {
          user = r;
          log("Inside controller");
          isLoading = false;
          update();
          Get.offAllNamed(RoutesNames.homeScreen);
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signout() async {
    isLoading = true;
    update();
    try {
      final result = await logout(NoParams());
      result.fold(
        (l) {
          showSnackBar(
            "OOPS!!!",
            getStringByFailure(l),
            isError: true,
          );
          isLoading = false;
          update();
        },
        (r) {
          isLoading = false;
          update();
          Get.offAllNamed(RoutesNames.loginScreen);
        },
      );
    } catch (e) {
      log(e.toString());
    }
    log("Inside controller");
  }
}
