import 'package:dialectos/routes/routes_names.dart';
import 'package:dialectos/view/home_screen.dart';
import 'package:dialectos/view/temp_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: RoutesNames.homeScreen, 
      page: () => HomeScreen(),
      ),
    GetPage(
      name: RoutesNames.tempScreen, 
      arguments: String,
      page: () => TempScreen(selectedAccent: Get.arguments),
      ),
  ];
}
