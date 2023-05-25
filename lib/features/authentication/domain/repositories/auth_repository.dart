import 'package:dialectos/core/error/failure.dart';
import 'package:dialectos/features/authentication/domain/entities/user_entitiy.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login();
  Future<Either<Failure, void>> logout();
}
