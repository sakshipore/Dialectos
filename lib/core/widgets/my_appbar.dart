import 'package:dialectos/constants/text_style.dart';
import 'package:dialectos/core/helpers/asset_helper.dart';
import 'package:dialectos/core/usecase/base_usecase.dart';
import 'package:dialectos/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:dialectos/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
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
                locator.get<AuthController>().signout();
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
