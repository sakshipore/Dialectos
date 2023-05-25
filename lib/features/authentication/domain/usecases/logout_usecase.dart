import 'package:dialectos/core/error/failure.dart';
import 'package:dialectos/core/usecase/base_usecase.dart';
import 'package:dialectos/features/authentication/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogOutUseCase extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  LogOutUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
