import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:preparely/views/splashScreen.dart';

import '../utilities/api_endpoints.dart';
import '../utilities/internet_check.dart';
import '../views/gridViewScreen.dart';

class LoginController extends GetxController {
//upon the starting of application LoginController is initializes and so these "TextEditingControllers" are also initialized and hence they are
// accessible to be passed as arguments to 'InputTextFieldWidget' so that they can receive the user input then store and carry it with them.
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // when using SharedPreferences for first time in the project so after importing the package in pubspec.yaml then kill and reinstall the app
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isLoading = false.obs;

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};

    try {
      isLoading(true);

      // checking if the internet is available or not to show a message "import 'package:preparely_app_project/utilities/internet_check.dart';"
      bool isInternetAvailable =
          await checkInternetAvailability(); // Check internet connectivity

      if (!isInternetAvailable) {
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.amber[200],
          textColor: Colors.black,
        );
        return;
      }

      if (passwordController.text.length < 5) {
        throw "Password should not be less than five characters";
      } else if (emailController.text.isEmpty) {
        throw Exception("please enter email");
      } else if (passwordController.text.isEmpty) {
        throw Exception("please enter password");
      }

      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginEmail);

      Map body = {
        "email": emailController.text.trim().toLowerCase(),
        "password": passwordController.text
      };
      //the api accepts data in "raw form" so we have to send data  in jsonEncoded form in post api
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body.toString());

        if (json['success'] == true) {
          var token = json['token'];
          print("token is : $token");
          //creating a public object for SharedPreferences so as to store the already declared private object "_prefs" on it so as to be used outside the class
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          print("printing prefs: ${prefs.get('token')}");
          emailController.clear();
          passwordController.clear();

          print("login successful");
          //if successfully logged In (ie; Credentials are correct)
          var sharedPref = await SharedPreferences
              .getInstance(); // this 'instance' of SharedPreferences is declared in the splash Screen
          // for 'KEYLOGIN' to be accessible here you must make the SplahScreen class and its inherited children as non-private and we are accessing this "KEYLOGIN" using class name because it is a static variable
          sharedPref.setBool(splashScreenState.KEYLOGIN, true);

          //"Get.offALL" means once the user goes forward then cannot go to any previous screen
          // if you put "Get.off" instead then on back button the LoginScreen cannot be accessed but screens before login SCREEN, e.g, WelcomeScreen can be accessed which is bad user experience

          Get.offAll(() => gridViewScreen(),
              transition: Transition.downToUp,
              duration: const Duration(milliseconds: 220));
        }
      } else {
        print("Response body2: ${response.body}");
        var errorMessage =
            jsonDecode(response.body)['message'] ?? "Unknown error occurred";
        print("erroMessage2: ${errorMessage.toString()}");
        throw Exception(errorMessage);
      }
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString(),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors
              .red, // when 'backgroundGradient' is used then this 'backgroundColor' will not work
          titleText: const Text("Notification"), // will overwrite the 'Error'
          messageText: Text(e
              .toString()), //this will overwrite the e.toString() provided above
          colorText: Colors.black,
          backgroundGradient:
              const LinearGradient(colors: [Color(0xff004880), Colors.white]),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal);
    } finally {
      isLoading(false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
