import 'package:dialectos/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController controller;
  MyTextField({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 40.h,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        // textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.h),
          prefixIcon:
              Icon(Icons.search, color: Color(0xff2C2C2C).withOpacity(0.3)),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: Color(0xffC5E83A),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: Color(0xffC5E83A),
            ),
          ),
          hintText: "Search accent",
          hintStyle: MyTextStyle.normalTextStyle.copyWith(
            fontSize: 14.sp,
            color: Color(0xff2C2C2C).withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
