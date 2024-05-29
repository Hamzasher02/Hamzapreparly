import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utilities/api_endpoints.dart';
import '../utilities/internet_check.dart';
import '../views/passwordResetScreen.dart';

class ForgotPasswordController extends GetxController {

  TextEditingController emailController = TextEditingController();

  Future<void> ForgotPassword () async{

    try{
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

      var headers = {'Content-Type' : 'application/json'};
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.forgotPassword);
      final Map body = {
        "email" : emailController.text.trim().toLowerCase()
      };

      final response = await http.post(url, body: jsonEncode(body), headers: headers);

      final json = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        print("Otp credentials: $json['success']$json['message']$json['otp']");
        Get.snackbar(
            "Notification",
            "The link for generating new password has been sent to your email",
            duration: const Duration(seconds: 4),
            backgroundColor: Color(0xff004880),            // when 'backgroundGradient' is used then this 'backgroundColor' will not work
            titleText: Text("Notification",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),       // will overwrite the 'Error'
            messageText: Text("${json['message']}",style: TextStyle(fontSize: 16)),  //this will overwrite the e.toString() provided above
            colorText: Colors.black,
           backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),

            isDismissible: true,
            dismissDirection: DismissDirection.horizontal
        );
      } else {
        var errorMessage = json ['message'] ?? "Unknown Error";
        throw Exception(errorMessage);
      }

    }on Exception catch (e) {

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
@override
  void dispose() {
  emailController.dispose();
    super.dispose();
  }

}