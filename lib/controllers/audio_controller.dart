import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialectos/services/dialectos_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioController extends GetxController {
  List<Map<String, dynamic>> dataList = [];
  List<String> accentList = [];
  List<String> suggestions = [];
  bool isLoading = true;
  TextEditingController controller = TextEditingController();
  final DialectosService service = DialectosService();

  Future<void> fetchAccents() async {
    try {
      List<Map<String, dynamic>> res = await service.fetchAccents();
      dataList = res;
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  void buildSuggestions(String query) {
    query = query.toLowerCase();
    if (query == "") {
      suggestions = accentList;
    } else {
      suggestions = accentList.where((element) {
        element = element.toLowerCase();
        return element.contains(query);
      }).toList();
    }
    update();
  }

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

  String getAudioOfSelectedAccent(String selectedAccent) {
    try {
      String audioFile = "";
      for (Map<String, dynamic> data in dataList) {
        if (data.containsKey(selectedAccent)) {
          audioFile = data[selectedAccent];
          return audioFile;
        }
      }
      log("Accent Not Found");
      return "";
    } catch (e) {
      log(e.toString());
      return "";
    }
  }

  // Future<void> getAllDocuments() async {
  //   await FirebaseFirestore.instance
  //       .collection('accents')
  //       .get()
  //       .then((QuerySnapshot snapshot) {
  //     for (var doc in snapshot.docs) {
  //       var data = doc.data();
  //       dataList.add(data as Map<String, dynamic>);
  //     }
  //   });

    // log(dataList.length.toString());
  // }

  Future<List<String>> getListOfAccents() async {
    try {
      log(dataList.length.toString());
      accentList = dataList
          .map((map) => map.keys.toList())
          .toList()
          .expand((list) => list)
          .toList();

      // log(accentList.toString());
      suggestions = accentList;
      return accentList;
    } catch (e) {
      return [];
    } finally {
      isLoading = false;
      update();
    }
  }
}
