import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

showSnackBar(String title, String subtitle, {bool isError = false}) {
  return Get.snackbar(
    title,
    subtitle,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: isError ? Color(0xfff56262) : Colors.green,
    borderRadius: 20.r,
    margin: EdgeInsets.all(15.w),
    colorText: Colors.white,
    duration: Duration(seconds: 2),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
