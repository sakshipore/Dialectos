import 'dart:async';
import 'dart:developer';
import 'dart:html' as html;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:dialectos/controllers/audio_controller.dart';

class PlayerController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isLoading = true;
  String selectedAccent;

  PlayerController({required this.selectedAccent});

  void changePosition(Duration currentPosition) {
    position = currentPosition;
    update();
  }

  // Future<File> _downloadFile(String url) async {
  //   final Directory tempDir = await getTemporaryDirectory();
  //   final File tempFile = File('${tempDir.path}/audio.mp3');

  //   final dio = Dio();
  //   await dio.download(url, tempFile.path);

  //   return tempFile;
  // }

  // Future<int> getAudioDuration(String url) async {
  //   final File audioFile = await _downloadFile(url);

  //   final FlutterFFprobe _flutterFFprobe = FlutterFFprobe();
  //   final Map<dynamic, dynamic> info =
  //       await _flutterFFprobe.getMediaInformation(audioFile.path);
  //   final int duration = int.parse(info['duration']);
  //   return duration;
  // }

  Future<int> getAudioDuration(String url) async {
    final completer = Completer<int>();
    final audio = html.AudioElement()..src = url;

    audio.onLoadedMetadata.listen((event) {
      final durationInSeconds = audio.duration.toInt();
      final durationInMilliseconds = durationInSeconds * 1000;
      completer.complete(durationInMilliseconds);
    });

    audio.onError.listen((error) {
      completer.completeError(error);
    });

    audio.load();

    return completer.future;
  }

  @override
  void onReady() async {
    //? Setup Controller and load accent
    AudioController audioController = Get.find<AudioController>();
    String url = audioController.getAudioOfSelectedAccent(selectedAccent);
    await audioPlayer.setUrl(url);

    if (kIsWeb) {
      int result = await getAudioDuration(url);
      duration = Duration(milliseconds: result);
      update();
    }

    log("Duration : ${duration.inSeconds}");

    // int result = await audioPlayer.getDuration();
    // log(result.toString());
    // duration = Duration(seconds: result);
    // update();

    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.PLAYING;
      update();
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      update();
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      position = newPosition;
      update();
    });
    isLoading = false;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.onClose();
  }
}
