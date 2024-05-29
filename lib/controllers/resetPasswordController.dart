import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../utilities/api_endpoints.dart';
import '../views/loginScreen.dart';

class ResetPasswordController extends GetxController {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> ResetPassword (String registeredEmail) async{

    try{

      var headers = {'Content-Type' : 'application/json'};
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.resetPassword);    //passing the link sent to email and then entered in the textFormField directly to API

      final Map body = {
        'email'           : registeredEmail.toString(),    // is passed from forgotPassword Controller to passwordResetScreen and then here
        'password'        : passwordController.text,
        'confirmPassword' : confirmPasswordController.text
      };
      print("printing body: $body");

      final response = await http.post(url, body: jsonEncode(body), headers: headers);
      print("${response.body}");

      final json = jsonDecode(response.body.toString());
      print("${json.toString()}");

      if(response.statusCode == 200) {

        print("successfully reset password");
        Get.offAll( ()=> const loginScreen(), );

        Get.snackbar(
            "Error",
            "Password changed successfully",
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,            // when 'backgroundGradient' is used then this 'backgroundColor' will not work
            titleText: const Text("Notification",style: TextStyle(fontSize: 16)),       // will overwrite the 'Error'
            messageText: const Text("Password changed successfully",style: TextStyle(fontSize: 16)),  //this will overwrite the e.toString() provided above
            colorText: Colors.black,
            backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal
        );

      }else {

        print("we are in the else block and status code is ${response.statusCode}");
        var errorMessage = json ['message'] ?? "Unknown Error";
        throw Exception(errorMessage);
      }

    }on Exception catch (e) {

      Get.snackbar(
          "Error",
          "Exceptions caught",
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,            // when 'backgroundGradient' is used then this 'backgroundColor' will not work
          titleText: const Text("Notification",style: TextStyle(fontSize: 16)),       // will overwrite the 'Error'
          messageText: Text(e.toString(), style: const TextStyle(fontSize: 16)),  //this will overwrite the e.toString() provided above
          colorText: Colors.black,
          backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal
      );
    }


  }

  @override
  void dispose() {

    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

}
