import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:dialectos/controllers/audio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TempScreen extends StatefulWidget {
  final String selectedAccent;
  TempScreen({super.key, required this.selectedAccent});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  AudioController audioController = Get.find<AudioController>();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FloatingActionButton(
          onPressed: () async {
            log("Selected Accent : ${widget.selectedAccent}");
            // int result =
            await audioPlayer.play(
              audioController.getAudioOfSelectedAccent(widget.selectedAccent),
            );
            // result == 1 ? log("AUDIO PLAYING") : log("AUDIO NOT PLAYING");
          },
        ),
      ),
    );
  }
}
