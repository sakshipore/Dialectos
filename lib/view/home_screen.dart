import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:dialectos/constants/text_style.dart';
import 'package:dialectos/controllers/audio_controller.dart';
import 'package:dialectos/routes/routes_names.dart';
import 'package:dialectos/widgets/my_appbar.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: GetBuilder<AudioController>(
          builder: (controller) {
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
                            SizedBox(height: 20.h),
                            ListView.builder(
                              itemCount: controller.accentList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    String selectedAccent =
                                        controller.accentList[index];
                                    log(selectedAccent);
                                    Get.toNamed(
                                      RoutesNames.audioScreen,
                                      arguments: selectedAccent,
                                    );
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
          },
        ),
      ),
    );
  }
}
