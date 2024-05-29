import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/api_endpoints.dart';
import '../utilities/internet_check.dart';
import 'logoutController.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();  //creating the instance (_prefs) of sharedPreferences

class PastPapersListController extends GetxController {

  // 'pastPapers' is an observable list of maps. This list will hold the fetched past paper data.
  RxList<Map<String, dynamic>> pastPapers = RxList<Map<String, dynamic>>();

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPastPapers();
  }

  Future<void> fetchPastPapers() async {  // 'fetchPastPapers' is an asynchronous method that fetches the data from the provided API endpoint.
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
      Uri url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.pastPapersList);

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body) as List<dynamic>;   // The decoded response from API is then cast to 'List<dynamic>' since the API response is an array.

        // By accessing the value property of pastPapers and assigning a new value to it, we explicitly notify Getx that the value of pastPapers has changed. This triggers the necessary updates and ensures that the UI reflects the latest data.
       //  The List<Map<String, dynamic>>.from(data) part is used to create a new list with the same values as the data list. Since data is of type List<dynamic>, we need to cast it to List<Map<String, dynamic>> to ensure that the types match and the assignment is valid.
        pastPapers.value = List<Map<String, dynamic>>.from(data); // The 'pastPapers.value' is set to a new List<Map<String, dynamic>> created from the decoded data using List<Map<String, dynamic>>.from(data). This assigns the fetched data to the pastPapers observable list.

      } else if (response.statusCode ==  400 ) {    // this condition works when token is Expired so we need to remove it from local storage

        LogoutController logoutController = Get.put(LogoutController());

        var errrorMessage = "Token expired. Please log in again";

        logoutController.handleLogout();

        throw Exception(errrorMessage);

      }
    }  on Exception catch (e) {
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
    } finally {
      isLoading(false);
    }
  }
}
