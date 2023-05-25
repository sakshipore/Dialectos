import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dialectos/core/network/network_info.dart';
import 'package:dialectos/features/authentication/data/datasources/auth_data_source.dart';
import 'package:dialectos/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:dialectos/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dialectos/features/authentication/domain/usecases/login_usecase.dart';
import 'package:dialectos/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:dialectos/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:dialectos/core/services/shared_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //! Controllers
  locator.registerFactory(
    () => AuthController(login: locator(), logout: locator()),
  );

  //! Usecases
  locator.registerLazySingleton(() => LoginUseCase(authRepository: locator()));
  locator.registerLazySingleton(() => LogOutUseCase(authRepository: locator()));

  //! Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplementation(
      dataSource: locator(),
      networkInfo: locator(),
    ),
  );

  //! Data Sources
  locator.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImplementation(sharedService: locator()),
  );

  //! Core
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: locator()),
  );
  locator.registerLazySingleton(() => MySharedService(prefs: locator()));

  //! External Libraries
  final sharedPreference = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => Connectivity());
  locator.registerLazySingleton(() => sharedPreference);
}
