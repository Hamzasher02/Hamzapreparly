import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HnewMdacatecontroller extends GetxController {
  RxList<Map<String, dynamic>> chapterDetailData = <Map<String, dynamic>>[].obs;

  Future<void> fetchChapterDetail(String categoryId) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("token");
      final response = await http.get(
        Uri.parse(
            "https://preparlybackend.steamminds.co/preparely/subcategory?categoryId=$categoryId"),
        headers: {"Authorization": "Bearer $token"},
      );
      if (kDebugMode) {
        print("Response Status Code: ${response.statusCode}");
      }
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<Map<String, dynamic>> parsedData = responseData
            .map<Map<String, dynamic>>((e) => e as Map<String, dynamic>)
            .toList();
        chapterDetailData.assignAll(parsedData);
        if (kDebugMode) {
          print('Chapter Detail Data: $chapterDetailData');
        }
      } else {
        // Handle HTTP error response
        print('HTTP error: ${response.statusCode}');
        // Throw an exception to be caught by the caller
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error while fetching chapter detail data: ${e.toString()}");
      // Rethrow the caught exception to be handled by the caller
      throw e;
    }
  }
}
