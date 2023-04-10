import 'dart:developer';

import 'package:dio/dio.dart';

class DialectosService {
  Future<List<dynamic>> fetchAccents() async {
    String url = "http://localhost:9000/accents";
    var response = await Dio().getUri(Uri.parse(url));
    // Dio().getUri(Uri.parse("http://localhost:9000/accents"))
    log(response.data.toString());
    return response.data;
  }
}
