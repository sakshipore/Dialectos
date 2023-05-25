import 'package:dialectos/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:dialectos/firebase_options.dart';
import 'package:dialectos/routes/routes.dart';
import 'package:dialectos/routes/routes_names.dart';
import 'package:dialectos/core/services/shared_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  bool isLoggedIn =
      await locator.get<MySharedService>().getLoginStatus() ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 840),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute:
              isLoggedIn ? RoutesNames.homeScreen : RoutesNames.loginScreen,
          getPages: AppRoutes.routes,
          theme: ThemeData(fontFamily: "Poppins"),
        );
      },
    );
  }
}
