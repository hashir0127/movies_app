import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/constant/backen_constant.dart';

class BackendCall{
  Future<Map<String, dynamic>> getRequest() async {
    http.Response? rawResponse;
    Map<String, dynamic> responseJson = {};
    try {
      rawResponse = await http.get(
        Uri.parse(moviesUrl),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
      );
      if (rawResponse.statusCode == 200) {
        responseJson = jsonDecode(rawResponse.body) as Map<String, dynamic>;
      } else {
        EasyLoading.showError(
            "Something went wrong status code:${rawResponse.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError(
          "Error :$e");
    }
    return responseJson;
  }
}