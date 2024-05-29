import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MocktestController extends GetxController {
  RxList<Map<String, dynamic>> pastPapers = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;

  Future<void> fetchmocktest(String categoryId) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("token");

      final response = await http.get(
        Uri.parse(
            "https://preparlybackend.steamminds.co/preparely/mocktest?categoryId=$categoryId"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        pastPapers.assignAll(data.cast<Map<String, dynamic>>());
        isLoading.value = false;
      } else {
        hasError.value = true;
        isLoading.value = false;
        throw Exception('Failed to fetch past papers: ${response.statusCode}');
      }
    } catch (e) {
      hasError.value = true;
      isLoading.value = false;
      throw e;
    }
  }
}
