import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextStyle {
  static const String poppinsFont = "Poppins";

  static TextStyle get normalTextStyle => TextStyle(
        fontFamily: poppinsFont,
        fontWeight: FontWeight.w400,
        color: Color(0xff2C2C2C),
        fontSize: 14.sp
      );

  static TextStyle get headingTextStyle => TextStyle(
        fontFamily: poppinsFont,
        fontWeight: FontWeight.w700,
        color: Color(0xff2C2C2C),
        fontSize: 30.sp,
      );

  static TextStyle get buttonTextStyle => TextStyle(
    fontFamily: poppinsFont,
    fontWeight: FontWeight.w500,
    color: Color(0xff2C2C2C),
    fontSize: 16.sp,
  );
}
