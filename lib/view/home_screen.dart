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
      appBar: AppBar(
        backgroundColor: Color(0xffC5E83A),
        toolbarHeight: 50.h,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () async {
              AuthController controller =
                  Get.put(AuthController(MySharedService(), FirebaseService()));
              await controller.logout();
            },
            child: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: GetBuilder<AudioController>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Icon(Icons.arrow_back_ios_new_rounded,
                                color: Color(0xffC5E83A), size: 20.sp
                                // size: 12.sp,
                                ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Back",
                              style: MyTextStyle.normalTextStyle
                                  .copyWith(fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        // Container(
                        //   height: 550.h,
                        //   width: MediaQuery.of(context).size.width,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10.r),
                        //     border: Border.all(
                        //       width: 1.w,
                        //       color: Color(0xff2C2C2C),
                        //     ),
                        //   ),
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 5.w, vertical: 5.h),
                        //     child: Text(
                        //       "On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.",
                        //       style: MyTextStyle.normalTextStyle,
                        //     ),
                        //   ),
                        // ),
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
                                Get.toNamed(RoutesNames.tempScreen,
                                    arguments: selectedAccent);
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
