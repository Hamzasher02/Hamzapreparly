import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/api_endpoints.dart';
import 'logoutController.dart';

final Future<SharedPreferences> _prefs = SharedPreferences
    .getInstance(); //creating the instance (_prefs) of sharedPreferences

class UserProfileController extends GetxController {
  var isLoading = true.obs;
  var firstName = "".obs;
  var lastName = "".obs;
  var email = "".obs;

  @override
  void onInit() {
    fetchUserProfile();
    super.onInit();
  }

  void fetchUserProfile() async {
    try {
      isLoading(true);

      final SharedPreferences prefs = await _prefs;

      Map<String, String> headers = {
        'Authorization': 'Bearer ${prefs.get('token')}'
      };

      Uri url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.userProfile);

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var json = response.body;
        var data = jsonDecode(json);

        firstName.value = data["user"]["firstName"];
        lastName.value = data["user"]["lastName"];
        email.value = data["user"]["email"];
      } else if (response.statusCode == 400) {
        // this condition works when token is Expired so we need to remove it from local storage

        LogoutController logoutController = Get.put(LogoutController());

        var errrorMessage = "Token expired. Please log in again";

        logoutController.handleLogout();

        throw Exception(errrorMessage);
      } else {
        print(
            'Request for profile failed with status: ${response.statusCode}.');
        print("failed to load userProfile");

        var errorMessage = jsonDecode(response.body)['message'] ??
            "Unknown userProfile error occurred";
        print("erroMessage: ${errorMessage.toString()}");
        throw Exception(errorMessage);
      }
    }

    // on Exception catch (e) {
    //
    //   Get.snackbar(
    //       "Error",
    //       e.toString(),
    //       duration: Duration(seconds: 4),
    //       backgroundColor: Colors.red,            // when 'backgroundGradient' is used then this 'backgroundColor' will not work
    //       titleText: const Text("Notification"),       // will overwrite the 'Error'
    //       messageText: Text(e.toString()),  //this will overwrite the e.toString() provided above
    //       colorText: Colors.black,
    //       backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),
    //
    //       isDismissible: true,
    //       dismissDirection: DismissDirection.horizontal
    //   );
    //
    // }

    finally {
      isLoading(false);
    }
  }
}
