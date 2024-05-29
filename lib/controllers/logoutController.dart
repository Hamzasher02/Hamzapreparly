import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:preparely/views/splashScreen.dart';
import '../utilities/api_endpoints.dart';
import '../utilities/internet_check.dart';
import '../views/loginScreen.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class LogoutController extends GetxController{
  Future<void> handleLogout() async {
    //function used in the Signout button in the Drawer bellow and logout happens in future always so we use async


    // checking if the internet is available or not to show a message "import 'package:preparely_app_project/utilities/internet_check.dart';"
    bool isInternetAvailable = await checkInternetAvailability(); // Check internet connectivity

    if (!isInternetAvailable) {
      Get.back();
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

    var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.logoutUser);
    var headers = {'Authorization': 'Bearer ${prefs.get('token')}'};

    print("my token before sending in header : ${prefs.get('token')}");

    try{
      final response = await http.get(url, headers: headers);

      final json = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        prefs.clear();
        print(
            "log out seccessful and printing token bellow after deleting it from memory");
        print(prefs.get('token'));

        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setBool(splashScreenState.KEYLOGIN, false);    // making KEYLOGIN == false so that user cannot come directly to dashboard anymore before doing login
        print(" sharedPref object value before cleared is: $sharedPref");
        Get.offAll(() => loginScreen());

      sharedPref.clear();    // it needs to be cleared to protect phone from unneccessary space consumption
      print(" sharedPref object value after cleared is: $sharedPref");

        Get.snackbar(
            "notification",
          json['message'],
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,            // when 'backgroundGradient' is used then this 'backgroundColor' will not work
            titleText: Text("Notification",style: TextStyle(fontSize: 16)),       // will overwrite the 'Error'
            messageText: Text("${json['message']}",style: TextStyle(fontSize: 16)),  //this will overwrite the e.toString() provided above
            colorText: Colors.black,
          backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),
            snackPosition: SnackPosition.TOP,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,);

      } else if (
      response.statusCode ==  400 ) {    // this condition works when token is Expired so we need to remove it from local storage

        prefs.clear();

        print( "loggig Out because token expired and now deleting token as well and printing bellow");
        print(prefs.get('token'));

        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setBool(splashScreenState.KEYLOGIN, false);

        print(" sharedPref object value before cleared is: ${sharedPref.toString()}");
        Get.offAll(() => loginScreen());

        sharedPref.clear();
        print(" sharedPref object value after cleared is: ${sharedPref.toString()}");

        Get.snackbar(
          "notification",
          json['message'],
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,            // when 'backgroundGradient' is used then this 'backgroundColor' will not work
          titleText: const Text("Notification",style: TextStyle(fontSize: 16)),       // will overwrite the 'Error'
          messageText: Text(json['message'],style: const TextStyle(fontSize: 16)),  //this will overwrite the e.toString() provided above
          colorText: Colors.black,
          backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),
          snackPosition: SnackPosition.TOP,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,);

      }
      else {
        var errorMessage = jsonDecode(response.body) ['message'] ?? "Unknown error occurred";
        throw Exception(errorMessage);
      }

    }on Exception catch (e) {
      Get.snackbar(
          "Error",
          e.toString(),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,            // when 'backgroundGradient' is used then this 'backgroundColor' will not work
          titleText: const Text("Notification",style: TextStyle(fontSize: 16)),       // will overwrite the 'Error'
          messageText: Text(e.toString(),style: const TextStyle(fontSize: 16)),  //this will overwrite the e.toString() provided above
          colorText: Colors.black,
          backgroundGradient: const LinearGradient(colors: [Colors.red,Colors.purpleAccent]),

          isDismissible: true,
          dismissDirection: DismissDirection.horizontal
      );

    }

  }
}