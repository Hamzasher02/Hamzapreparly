import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/api_endpoints.dart';
import '../utilities/internet_check.dart';
import 'logoutController.dart';


final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();  //creating the instance (_prefs) of sharedPreferences

class MockListController extends GetxController {
  var mockData = <dynamic>[].obs;

   var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }


   fetchData() async {
    try {

      isLoading(true);

      // checking if the internet is available or not to show a message "import 'package:preparely_app_project/utilities/internet_check.dart';"
      bool isInternetAvailable = await checkInternetAvailability(); // Check internet connectivity

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

      Map<String, String> headers = {'Authorization': 'Bearer ${prefs.get('token')}'};
      Uri url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.mockList);

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        mockData.value = jsonResponse;

        print("the MockTest List data is : ${mockData.toString()}");

      } else if (response.statusCode ==  400 ) {    // this condition works when token is Expired so we need to remove it from local storage

        LogoutController logoutController = Get.put(LogoutController());

        logoutController.handleLogout();

      }else if (response.statusCode ==  400 ) {    // this condition works when token is Expired so we need to remove it from local storage

        LogoutController logoutController = Get.put(LogoutController());

        var errrorMessage = "Token expired. Please log in again";

        logoutController.handleLogout();

        throw Exception(errrorMessage);

      }
    } on Exception catch (e) {
      Get.snackbar(
          "Error",
          e.toString(),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,            // when 'backgroundGradient' is used then this 'backgroundColor' will not work
          titleText: const Text("Notification"),       // will overwrite the 'Error'
          messageText: Text(e.toString()),  //this will overwrite the e.toString() provided above
          colorText: Colors.black,
          backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),

          isDismissible: true,
          dismissDirection: DismissDirection.horizontal
      );
    }finally {
      isLoading(false);
    }
  }
}
