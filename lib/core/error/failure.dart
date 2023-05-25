import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  const Failure({this.properties = const []});

  @override
  List<Object?> get props => properties;
}

class ServerFailure extends Failure {
  const ServerFailure();
}

class SignInFailure extends Failure {
  const SignInFailure();
}

class SignOutFailure extends Failure {
  const SignOutFailure();
}

class CacheFailure extends Failure {
  const CacheFailure();
}

class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure();
}

class NoAccoutSelectedFailure extends Failure {
  const NoAccoutSelectedFailure();
}
