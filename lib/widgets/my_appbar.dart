import 'package:dialectos/constants/text_style.dart';
import 'package:dialectos/controllers/auth_controller.dart';
import 'package:dialectos/helpers/asset_helper.dart';
import 'package:dialectos/services/firebase_service.dart';
import 'package:dialectos/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size(360.w, 50.h);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 360.w,
      color: Color(0xffC5E83A),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
        child: Row(
          children: [
            Image.asset(AssetHelper.logo),
            SizedBox(width: 10.w),
            Text(
              "Dialectos",
              style: MyTextStyle.normalTextStyle.copyWith(fontSize: 16),
            ),
            Spacer(),
            InkWell(
              onTap: () async {
                AuthController controller = Get.put(
                    AuthController(MySharedService(), FirebaseService()));
                await controller.logout();
              },
              child: Icon(
                Icons.exit_to_app_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
