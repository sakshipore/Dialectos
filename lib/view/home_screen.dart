import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:dialectos/constants/text_style.dart';
import 'package:dialectos/controllers/audio_controller.dart';
import 'package:dialectos/controllers/auth_controller.dart';
import 'package:dialectos/routes/routes_names.dart';

import '../services/firebase_service.dart';
import '../services/shared_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AudioController audioController = Get.put(AudioController());
  AudioPlayer audioPlayer = AudioPlayer();
  String? documentId;
  String? audioFileUrl;

  @override
  void initState() {
    gettingAudioFiles();
    super.initState();
  }

  gettingAudioFiles() async {
    await audioController.getAllDocuments();
    await audioController.getListOfAccents();
    // documentId = await audioController.getAudioFileDocumentId("afrikaans");
    // audioFileUrl = await audioController.getAudioFileUrl(documentId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xffC5E83A),
      //   toolbarHeight: 50.h,
      //   elevation: 0,
      //   actions: [
      //     InkWell(
      //       onTap: () async {
      //         AuthController controller =
      //             Get.put(AuthController(MySharedService(), FirebaseService()));
      //         await controller.logout();
      //       },
      //       child: Icon(
      //         Icons.logout,
      //         color: Colors.black,
      //       ),
      //     ),
      //   ],
      // ),
      body: GetBuilder<AudioController>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: controller.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffC5E83A),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        // Row(
                        //   children: [
                        //     Icon(Icons.arrow_back_ios_new_rounded,
                        //         color: Color(0xffC5E83A), size: 20.sp
                        //         // size: 12.sp,
                        //         ),
                        //     SizedBox(
                        //       width: 10.w,
                        //     ),
                        //     Text(
                        //       "Back",
                        //       style: MyTextStyle.normalTextStyle
                        //           .copyWith(fontSize: 12.sp),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Accent",
                              style: MyTextStyle.headingTextStyle,
                            ),
                            Icon(
                              Icons.search,
                              color: Color(0xffC5E83A),
                              size: 25.sp,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        ListView.builder(
                          itemCount: controller.accentList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                String selectedAccent =
                                    await controller.accentList[index];
                                log(selectedAccent);
                                Get.toNamed(RoutesNames.audioScreen,
                                    arguments: selectedAccent);
                                // Get.toNamed(RoutesNames.audioScreen,
                                //     arguments: selectedAccent);
                              },
                              child: ListTile(
                                title: Text(
                                  controller.accentList[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            ),
          ),
        );
      }),
    );
  }
}
