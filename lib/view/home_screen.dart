import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:dialectos/widgets/loader.dart';
import 'package:dialectos/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dialectos/constants/text_style.dart';
import 'package:dialectos/controllers/audio_controller.dart';
import 'package:dialectos/routes/routes_names.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AudioController audioController = Get.put(AudioController());
  AudioPlayer audioPlayer = AudioPlayer();
  bool isSearching = false;

  @override
  void initState() {
    gettingAudioFiles();
    super.initState();
  }

  gettingAudioFiles() async {
    await audioController.getAllDocuments();
    await audioController.getListOfAccents();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AudioController>(
          builder: (controller) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: controller.isLoading
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Center(child: LoadingWidget()),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                isSearching
                                    ? MyTextField(
                                        controller: controller.controller,
                                        onChanged: (value) {
                                          audioController
                                              .buildSuggestions(value);
                                        },
                                      )
                                    : Text(
                                        "Select Accent",
                                        style: MyTextStyle.headingTextStyle,
                                      ),
                                Spacer(),
                                isSearching
                                    ? Container()
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isSearching = true;
                                          });
                                        },
                                        child: Icon(
                                          Icons.search,
                                          color: Color(0xffC5E83A),
                                          size: 25.sp,
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            ListView.builder(
                              itemCount: controller.suggestions.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () async {
                                      String selectedAccent =
                                          controller.suggestions[index];
                                      Get.toNamed(RoutesNames.audioScreen,
                                          arguments: selectedAccent);
                                    },
                                    child: ListTile(
                                      title: Text(
                                        controller.suggestions[index],
                                      ),
                                    ));
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
