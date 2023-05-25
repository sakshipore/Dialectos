import 'dart:developer';

import 'package:dialectos/core/error/exception.dart';
import 'package:dialectos/core/error/failure.dart';
import 'package:dialectos/core/network/network_info.dart';
import 'package:dialectos/features/authentication/data/datasources/auth_data_source.dart';
import 'package:dialectos/features/authentication/domain/entities/user_entitiy.dart';
import 'package:dialectos/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImplementation extends AuthRepository {
  final AuthDataSource dataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImplementation({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> login() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await dataSource.login();
        log("Inside Login ");
        return right(user);
      } on SignInException {
        return left(SignInFailure());
      } on NoAccountSelectedException {
        return left(NoAccoutSelectedFailure());
      }
    } else {
      return left(NoInternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await dataSource.logout();
        return right(res);
      } on SignOutException {
        return left(SignOutFailure());
      } on NoAccountSelectedException {
        return left(NoAccoutSelectedFailure());
      }
    } else {
      return left(NoInternetConnectionFailure());
    }
  }
}
