import 'package:dialectos/bindings/auth_binding.dart';
import 'package:dialectos/routes/routes_names.dart';
import 'package:dialectos/view/home_screen.dart';
import 'package:dialectos/view/login_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: RoutesNames.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: RoutesNames.loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
  ];
}
