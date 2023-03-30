import 'package:dialectos/constants/text_style.dart';
import 'package:dialectos/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectedAccentScreen extends StatelessWidget {
  String selectedAccent;
  SelectedAccentScreen({super.key, required this.selectedAccent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffC5E83A),
        toolbarHeight: 50.h,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Welcome",
                  style: MyTextStyle.normalTextStyle.copyWith(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Container(
                  height: 150.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      width: 1.w,
                      color: Color(0xff2C2C2C),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedAccent,
                          style: MyTextStyle.normalTextStyle
                              .copyWith(fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 65.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              RoutesNames.audioScreen,
                              arguments: selectedAccent,
                            );
                          },
                          child: Container(
                            height: 40.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Color(0xffC5E83A),
                            ),
                            child: Center(
                              child: Text(
                                "Continue",
                                style: MyTextStyle.buttonTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
