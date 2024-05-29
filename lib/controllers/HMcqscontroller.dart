import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MsqsDController extends GetxController {
  RxList<Map<String, dynamic>> mcqsData = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;

  Future<void> fetchMcqsDetail(String categoryId) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("token");
      final response = await http.get(
        Uri.parse(
            "https://preparlybackend.steamminds.co/preparely/mcq?categoryId=$categoryId"),
        headers: {"Authorization": "Bearer $token"},
      );
      if (kDebugMode) {
        print("Response Status Code: ${response.statusCode}");
      }
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        mcqsData.assignAll(data.cast<Map<String, dynamic>>());
        if (kDebugMode) {
          print('MCQs Data: $mcqsData');
        }
        // Set isLoading to false after data is fetched successfully
        isLoading.value = false;
      } else {
        // Handle HTTP error response
        print('HTTP error: ${response.statusCode}');
        // Throw an exception to be caught by the caller
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error while fetching MCQs data: ${e.toString()}");
      // Set hasError to true when an error occurs
      hasError.value = true;
      // Set isLoading to false after handling error
      isLoading.value = false;
      // Rethrow the caught exception to be handled by the caller
      throw e;
    }
  }

  void fetchPastPapers(String subjectId) {}
}
