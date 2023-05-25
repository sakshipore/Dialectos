import 'package:dialectos/constants/text_style.dart';
import 'package:dialectos/controllers/auth_controller.dart';
import 'package:dialectos/core/helpers/asset_helper.dart';
import 'package:dialectos/core/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 400.h,
              child: Image.asset(AssetHelper.signupImage),
            ),
            SizedBox(height: 30.h),
            GetBuilder<AuthController>(
              builder: (controller) {
                return InkWell(
                  onTap: () async {
                    await controller.login();
                  },
                  child: Container(
                    height: 40.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Color(0xffC5E83A),
                    ),
                    child: Center(
                      child: controller.isLoading
                          ? LoadingWidget()
                          : Text(
                              "Sign up with Google",
                              style: MyTextStyle.buttonTextStyle,
                            ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
