import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:preparely/models/DropdownModel.dart';
import 'package:preparely/utilities/sharedPrefernces/sharedPreferences.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/api_endpoints.dart';
import '../utilities/internet_check.dart';
import 'logoutController.dart';

final Future<SharedPreferences> _prefs = SharedPreferences
    .getInstance(); //creating the instance (_prefs) of sharedPreferences

class DropdownController extends GetxController {
  var isLoading = true.obs;
  RxList<DropdownModel> dropdownList = <DropdownModel>[].obs;

  @override
  void onInit() {
    fetchDropdownList();
    super.onInit();
  }

  @override
  Future<void> refresh() async {
    fetchDropdownList();
    await Future.delayed(const Duration(seconds: 1));
  }

  RxList<DropdownModel> getDropdownListByExamName(String examName) {
    return dropdownList.where((item) => item.fullName == examName).toList().obs;
  }

  void fetchDropdownList() async {
    try {
      isLoading(true);

      bool isInternetAvailable = await checkInternetAvailability();

      if (!isInternetAvailable) {
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFFFFEB3B),
          textColor: Colors.black,
        );
        return;
      }

      final SharedPreferences prefs = await _prefs;

      var headers = {'Authorization': 'Bearer ${prefs.get('token')}'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.dropdownCategories);

      var response = await http.get(url, headers: headers);

      print("Complete Response: ${response}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> decodedJson = json.decode(response.body);

        if (decodedJson.isNotEmpty) {
          List<DropdownModel> models = [];

          decodedJson.forEach((jsonObj) {
            final modelClassObj = DropdownModel.fromJson(jsonObj);
            models.add(modelClassObj);
          });

          dropdownList.assignAll(models);
          print("my drop down list :$dropdownList");

          var id = decodedJson[0]["_id"];
          SharedPreferencesHelper.storeToken(id);
        } else {
          print("Empty response or unexpected format");
        }
      } else if (response.statusCode == 400) {
        LogoutController logoutController = Get.put(LogoutController());

        var errorMessage = "Token expired. Please log in again";

        logoutController.handleLogout();

        Get.snackbar("Error", errorMessage,
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
            titleText:
                const Text("Notification", style: TextStyle(fontSize: 16)),
            messageText:
                Text(errorMessage, style: const TextStyle(fontSize: 16)),
            colorText: Colors.black,
            backgroundGradient:
                const LinearGradient(colors: [Color(0xff004880), Colors.white]),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal);
      } else {
        print('Error statusCode is: ${response.statusCode}');
      }
    } finally {
      isLoading(false);
    }
  }
}
