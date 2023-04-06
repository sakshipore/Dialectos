import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: SizedBox(
        height: 15.h,
        width: 80.w,
        child: LoadingIndicator(
          indicatorType: Indicator.ballBeat,
          colors: const [Color(0xff2C2C2C)],
        ),
      ),
    );
  }
}
