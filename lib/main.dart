import 'package:dialectos/firebase_options.dart';
import 'package:dialectos/routes/routes.dart';
import 'package:dialectos/routes/routes_names.dart';
import 'package:dialectos/services/shared_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool isLoggedIn = await MySharedService().getLoginStatus() ?? false;
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
          // TODO : Persistent Login Check
          initialRoute: RoutesNames.homeScreen,
          getPages: AppRoutes.routes,
          theme: ThemeData(
            fontFamily: "Poppins",
          ),
        );
      },
    );
  }
}
