import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AudioController extends GetxController {
  List<Map<String, dynamic>> dataList = [];
  List<String> accentList = [];
  bool isLoading = true;
  // Future<String> getAudioFileDocumentId(String audioFileName) async {
  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance
  //         .collection('accents')
  //         .where('name', isEqualTo: 'afrikaans')
  //         .get();

  //     final docSnapshot = querySnapshot.docs[0];
  //     log("AUDIO FILE DOCUMENT ID $docSnapshot.id");
  //     return docSnapshot.id;
  //   } catch (e) {
  //     log("AUDIO FILE DOCUMENT ID $e.toString()");
  //     return "";
  //   }
  // }

  // Future<String> getAudioFileUrl(String documentId) async {
  //   try {
  //     final docSnapshot = await FirebaseFirestore.instance
  //         .collection('accents')
  //         .doc(documentId)
  //         .get();

  //     final data = docSnapshot.data();
  //     if (data != null && data['audioUrl'] != null) {
  //       log("AUDIO FILE URL $data['audioUrl']");
  //       return data['audioUrl'];
  //     } else {
  //       return "";
  //     }
  //   } catch (e) {
  //     log("AUDIO FILE URL $e.toString()");
  //     return "";
  //   }
  // }

  Future<String> getAudioOfSelectedAccent(String selectedAccent) async {
    try {
      String audioFile = "";
      for (Map<String, dynamic> data in dataList) {
        if (data.containsKey(selectedAccent)) {
          audioFile = data[selectedAccent];
          break;
        }
      }
      log(audioFile);
      return audioFile;
    } catch (e) {
      log(e.toString());
      return "";
    } finally {
      update();
    }
  }

  Future<void> getAllDocuments() async {
    await FirebaseFirestore.instance
        .collection('accents')
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        var data = doc.data();
        dataList.add(data as Map<String, dynamic>);
      }
    });

    // log(dataList.toString());
  }

  Future<List<String>> getListOfAccents() async {
    try {
      log(dataList.length.toString());
      accentList = dataList
          .map((map) => map.keys.toList())
          .toList()
          .expand((list) => list)
          .toList();

      log(accentList.toString());
      return accentList;
    } catch (e) {
      return [];
    } finally {
      isLoading = false;
      update();
    }
  }
}
