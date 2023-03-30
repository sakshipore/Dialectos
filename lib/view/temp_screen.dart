import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:dialectos/controllers/audio_controller.dart';
import 'package:flutter/material.dart';

class TempScreen extends StatefulWidget {
  String selectedAccent;
  TempScreen({super.key, required this.selectedAccent});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  AudioController audioController = AudioController();
  AudioPlayer audioPlayer = AudioPlayer();
  String audioFile = "";

  @override
  void initState() {
    getAudioFile();
    super.initState();
  }

  getAudioFile() async {
    audioFile =
        await audioController.getAudioOfSelectedAccent(widget.selectedAccent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FloatingActionButton(
          onPressed: () async {
            int result = 
            await audioPlayer.play(audioFile);
            // result == 1 ? log("AUDIO PLAYING") : log("AUDIO NOT PLAYING");
          },
        ),
      ),
    );
  }
}
