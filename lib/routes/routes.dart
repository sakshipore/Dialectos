import 'package:dialectos/routes/routes_names.dart';
import 'package:dialectos/view/home_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: RoutesNames.homeScreen, 
      page: () => HomeScreen(),
      ),
  ];
}
