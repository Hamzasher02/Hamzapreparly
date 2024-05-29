import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VideoDController extends GetxController {
  RxList Videodata = [].obs;

  Future<void> fetchVideoDetail(String categgoryId) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? id = sharedPreferences.getString("token");
      final response = await http.get(
        Uri.parse(
            "https://preparlybackend.steamminds.co/preparely/video?categoryId=$categgoryId"),
        headers: {"Authorization": "Bearer $id"},
      );
      if (kDebugMode) {
        print("Response Status Code: ${response.statusCode}");
      }
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        Videodata.assignAll(data);
        if (kDebugMode) {
          print('Chapter Detail Data: $Videodata');
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
