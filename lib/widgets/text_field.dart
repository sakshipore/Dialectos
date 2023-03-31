import 'package:dialectos/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController controller;
  MyTextField({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      decoration: InputDecoration(
        prefixIcon:
            Icon(Icons.search, color: Color(0xff2C2C2C).withOpacity(0.3)),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff2C2C2C),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff2C2C2C),
          ),
        ),
        hintText: "Search accent",
        hintStyle: MyTextStyle.normalTextStyle.copyWith(
          fontSize: 10.sp,
          color: Color(0xff2C2C2C).withOpacity(0.3),
        ),
      ),
    );
  }
}
