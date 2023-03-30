import 'package:dialectos/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "HOME SCREEN",
            style: MyTextStyle.normalTextStyle.copyWith(fontSize: 20.sp),
          ),
        ),
      ),
    );
  }
}
