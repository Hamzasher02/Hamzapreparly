import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MDCATDetailController extends GetxController {
  RxList mdcatDetailData = [].obs;

  Future<void> fetchMDCATDetail(String categoryId) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? id = sharedPreferences.getString("token");
      final response = await http.get(
        Uri.parse(
            "https://preparlybackend.steamminds.co/preparely/subject?categoryId=$categoryId"),
        headers: {"Authorization": "Bearer $id"},
      );
      if (kDebugMode) {
        print("Response Status Code: ${response.statusCode}");
      }
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        mdcatDetailData.assignAll(data);
        if (kDebugMode) {
          print('MDCAT Detail Data: $mdcatDetailData');
        }
      } else {
        // Handle HTTP error response
        print('HTTP error: ${response.statusCode}');
        // Throw an exception to be caught by the caller
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error while fetching MDCAT detail data: ${e.toString()}");
      // Rethrow the caught exception to be handled by the caller
      throw e;
    }
  }
}
