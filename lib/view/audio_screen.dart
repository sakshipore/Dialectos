import 'package:dialectos/constants/text_style.dart';
import 'package:dialectos/controllers/player_controller.dart';
import 'package:dialectos/widgets/loader.dart';
import 'package:dialectos/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AudioScreen extends StatefulWidget {
  final String selectedAccent;
  AudioScreen({super.key, required this.selectedAccent});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  late PlayerController controller;

  @override
  void initState() {
    controller =
        Get.put(PlayerController(selectedAccent: widget.selectedAccent));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GetBuilder<PlayerController>(
                builder: (controller) {
                  return controller.isLoading
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Center(child: LoadingWidget()),
                        )
                      : Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 15.h),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_back_ios_new_rounded,
                                          color: Color(0xffC5E83A), size: 20.sp
                                          // size: 12.sp,
                                          ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "Back",
                                        style: MyTextStyle.normalTextStyle
                                            .copyWith(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.sp),
                                Container(
                                  // height: 400.h,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      width: 1.w,
                                      color: Color(0xff2C2C2C),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 15.h),
                                    child: Text(
                                      "Please call Stella.  Ask her to bring these things with her from the store:  Six spoons of fresh snow peas, five thick slabs of blue cheese, and maybe a snack for her brother Bob.  We also need a small plastic snake and a big toy frog for the kids.  She can scoop these things into three red bags, and we will go meet her Wednesday at the train station.",
                                      style: MyTextStyle.normalTextStyle
                                          .copyWith(fontSize: 20.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 80.h,
                            ),
                            Slider(
                              min: 0,
                              max: controller.duration.inSeconds.toDouble(),
                              value: controller.position.inSeconds.toDouble(),
                              activeColor: Color(0xffC5E83A),
                              onChanged: (value) async {
                                final position =
                                    Duration(seconds: value.toInt());
                                await controller.audioPlayer.seek(position);
                                controller.changePosition(position);
                              },
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (controller.isPlaying) {
                                  await controller.audioPlayer.pause();
                                } else {
                                  await controller.audioPlayer.resume();
                                }
                              },
                              child: CircleAvatar(
                                radius: 45.r,
                                backgroundColor: Color(0xffC5E83A),
                                child:
                                    // color: Color(0xffC5E83A),
                                    controller.isPlaying
                                        ? SvgPicture.asset(
                                            "assets/icons/pause.svg",
                                            height: 24.h,
                                            width: 24.w,
                                          )
                                        : SvgPicture.asset(
                                            "assets/icons/play.svg",
                                            height: 24.h,
                                            width: 24.w,
                                          ),
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
