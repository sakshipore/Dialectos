import 'dart:developer';

import 'package:dialectos/core/error/failure.dart';
import 'package:dialectos/core/usecase/base_usecase.dart';
import 'package:dialectos/features/authentication/domain/entities/user_entitiy.dart';
import 'package:dialectos/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUseCase extends UseCase<UserEntity, void> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(void params) async {
    final res = await authRepository.login();
    log("Inside LogIn UseCase");
    return res;
  }
}
