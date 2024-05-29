
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/api_endpoints.dart';
import '../utilities/internet_check.dart';
import '../views/loginScreen.dart';

class RegisterationController extends GetxController {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail () async{

    try {
      List<String> exceptions = [];

      if (firstNameController.text.isEmpty && lastNameController.text.isEmpty && emailController.text.isEmpty && phoneController.text.isEmpty && passwordController.text.isEmpty) {
        exceptions.add("All fields are empty, please fill the data");
        //throw exceptions; // this "throw" will be needed if
      } else {            // we are adding all exceptions to the "list of exceptions" therefore we use "if-if" statement instead of "if-else if"
        if (firstNameController.text.isEmpty) {
          exceptions.add("Please Enter first Name");
        }
        if (lastNameController.text.isEmpty) {
          exceptions.add("Please Enter last Name");
        }
        if (emailController.text.isEmpty) {
          exceptions.add("Please Enter your email");
        }
        if (phoneController.text.isEmpty) {
          exceptions.add("Please Enter your Phone Number");
        }
        if (passwordController.text.isEmpty) {
          //if password is not entered show "Enter Password" exception otherwise if "(exceptions.isNotEmpty) {throw exceptions;}" is
          //... enclosed inside the else{} brackets and if it is outside the else{} brackets then no need for us to throw exception from here
          //... because in that case "(exceptions.isNotEmpty) {throw exceptions;}" will work for both if{} and else{} blocks.
          exceptions.add("Please Enter your password");
        } else if (passwordController.text.length < 5) {
          exceptions.add("Password should have at least six characters");
        }
      }
      if (exceptions.isNotEmpty) {
        throw exceptions;
      }
    } on List<String> catch (e) {    //'e' is not an iterable object therefore even if we throw a List here we cannot extract the data
      //... from it by applying a loop and iterating it to get each item therefore we change the type of 'e' to a List of type <String>
      Get.back();

      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [
              Column(
                children: e.map((ex) => Text(ex)).toList(),
                //the above statement is converting each element in the List<String> e into a Text widget.
                //...for example, if e was ["error 1", "error 2"], the result of e.map((ex) => Text(ex)).toList() would be a List<Text> of two Text widgets,
                //...one with text set to "error 1", and the other with text set to "error 2".
                // In this case, the result of map is passed as children to the Column widget, which will display all the Text widgets in a vertical stack.
              ),
            ],
          );
        },
      );
    }

    try {

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

      var headers = {'Content-Type' : 'application/json'};
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.registerEmail);

      final Map body = {
        'firstName' : firstNameController.text,
        'lastName' : lastNameController.text,
        'email' : emailController.text.trim().toLowerCase(),
        'password' : passwordController.text,
        'phonenumber' : phoneController.text
      };

      final response = await http.post(url,body: jsonEncode(body), headers: headers);

      print("Printing response ${jsonDecode(response.body.toString())}");

      final json = jsonDecode(response.body.toString());

      if (response.statusCode == 201) {
          if (json['success'] == true) {
            var token = json['token'];

            print(token.toString());

            final SharedPreferences? prefs = await _prefs;

            await prefs?.setString('token', token);
            firstNameController.clear();
            lastNameController.clear();
            emailController.clear();
            phoneController.clear();
            passwordController.clear();

            Get.off(() => loginScreen());

            Get.snackbar(
              "Notification: ", "Registeration Successful",
              titleText: const Text("Notification",style: TextStyle(fontSize: 16)),
              duration: const Duration(seconds: 4),
              colorText: Colors.black,
                backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),
                isDismissible: true,
                dismissDirection: DismissDirection.horizontal
            );
          }
      } else if (response.statusCode == 500) {
        var errorMessage = "This user is already registered";
            throw Exception(errorMessage);
      } else {
        throw Exception(jsonDecode((response.body)) ['message'] ?? "Unknown Exception Occured");

        // var errorMessage = "Unknown Exception Occurred";   // by default errorMessage has this value
        // if (json.containsKey('message')) {                  // if json variable that has total API response contains message key then 'message' shall be stored on error message and then thrown as exception
        //   errorMessage = json['message'];
        // }
        // throw Exception(errorMessage);
      }
    } on Exception catch(e) {
    Get.back();

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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

}