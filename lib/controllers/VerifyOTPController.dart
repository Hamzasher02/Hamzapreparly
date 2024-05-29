import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/api_endpoints.dart';
import '../views/passwordResetScreen.dart';

class VerifyOTPController extends GetxController {

  TextEditingController pinCodeController = TextEditingController();

  final otp = '';
  final email = '';

  Future<void> verifyOTP(String registeredEmail) async {
    try {
      print("this is pincode controller value: ${pinCodeController.text}");
      print('this is email registered email: ${registeredEmail.toString()}');


      Map<String, String> headers = {
        'Content-Type' : 'application/json'
      };

      Uri url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.verifyOTP);

      Map body = {
        "otp": pinCodeController.text,
        "email": registeredEmail.toString(),
        // is passed from forgotPassword Controller to passwordResetScreen and then here
      };

      final response = await http.post(
          url, body: jsonEncode(body), headers: headers);

      final json = jsonDecode(response.body.toString());
      print("the response from API : $json");

      if (response.statusCode == 200) {
        print('if status code is 200: Status is ${response.statusCode}');

        pinCodeController.clear();

        print("otp verification successful");
        print("printing pinCodeController after cleared: ${pinCodeController.text}");

        Get.to(() =>
            ResetPasswordScreen(registeredEmail: registeredEmail
                .toString()),  transition: Transition.downToUp,duration: const Duration(milliseconds: 220)); //passing the email provided by user for forgot password to reset password scren


        Get.snackbar(
            "Notification",
            "OTP verification successful",
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
            // when 'backgroundGradient' is used then this 'backgroundColor' will not work
            titleText: const Text("Notification", style: TextStyle(fontSize: 16)),
            // will overwrite the 'Error'
            messageText: Text(
                "${json['message']}", style: const TextStyle(fontSize: 16)),
            //this will overwrite the e.toString() provided above
            colorText: Colors.black,
            backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),

            isDismissible: true,
            dismissDirection: DismissDirection.horizontal
        );
      } else {
        print('if status code is not 200: Status is ${response.statusCode}');
        var errorMessage = json ['message'] ?? "Unknown Error";
        throw Exception(errorMessage);
      }
    } on Exception catch (e) {

      Get.snackbar(
          "Error",
          e.toString(),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,            // when 'backgroundGradient' is used then this 'backgroundColor' will not work
          titleText: const Text("Notification",style: TextStyle(fontSize: 16)),       // will overwrite the 'Error'
          messageText: Text("${e.toString()}",style: const TextStyle(fontSize: 16)),  //this will overwrite the e.toString() provided above
          colorText: Colors.black,
          backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),

          isDismissible: true,
          dismissDirection: DismissDirection.horizontal
      );
    }
  }
}
