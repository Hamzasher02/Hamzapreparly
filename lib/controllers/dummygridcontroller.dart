import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DummygridController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> listgrid = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> selectedData = <Map<String, dynamic>>[].obs;

  Future<void> fetchData(BuildContext context) async {
    try {
      isLoading(true);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? id = sharedPreferences.getString("token");
      var response = await http.get(
        Uri.parse('https://preparlybackend.steamminds.co/preparely/category'),
        headers: {"Authorization": "Bearer $id"},
      );

      if (kDebugMode) {
        print("Response status code: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        List<dynamic> gridData = jsonDecode(response.body);
        listgrid.value = gridData.cast<Map<String, dynamic>>();
        if (kDebugMode) {
          print("Grid data: $listgrid");
        }
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading(false);
    }
  }
}
