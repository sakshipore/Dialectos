import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

showSnackBar(String title, String subtitle, Icon icon) {
  return Get.snackbar(
    title,
    subtitle,
    icon: icon,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    borderRadius: 20.r,
    margin: EdgeInsets.all(15.w),
    colorText: Colors.white,
    duration: Duration(seconds: 2),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
