import 'package:dialectos/core/error/failure.dart';

String getStringByFailure(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return "Server failure!!!";
    case CacheFailure:
      return "Cache failure!!!";
    case SignInFailure:
      return "Signin failure!!!";
    case SignOutFailure:
      return "Signout failure!!!";
    case NoAccoutSelectedFailure:
      return "No accoutn selected!!!";
    case NoInternetConnectionFailure:
      return "Not connected to internet!!!";
    default:
      return "Something went wrong!!!";
  }
}
