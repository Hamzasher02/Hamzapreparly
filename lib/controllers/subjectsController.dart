import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/subjectsModel.dart';
import '../utilities/api_endpoints.dart';
import '../utilities/internet_check.dart';
import 'logoutController.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();    //creating the instance (_prefs) of sharedPreferences

class SubjectsController extends GetxController {
  var subjectsList = <SubjectsModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchSubjects();
    super.onInit();
  }

  @override
  Future<void> refresh() async {
    // Fetch or refresh data again
    fetchSubjects(); // Call your fetchCategoryList method again
    await Future.delayed(const Duration(seconds: 1));

  }

  void fetchSubjects() async {
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

      var headers = {'Authorization': 'Bearer ${prefs.get('token')}'};
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.subject);

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);   // response from API is a dynamic List
        print("subjects Response: ${jsonResponse.toString()}");

        List<SubjectsModel> models = [];   // After we have converted all objects of dynamic list to dataType of model class then we will store them here
         //Here we will run a loop to convert every item of dynamic list to the dataType of ModelClass
        jsonResponse.forEach((jsonObj) {
          final modelClassObj =  SubjectsModel.fromJson(jsonObj); // convertin each item of dynamic list to DataType of Modelclass and storing on the Object of Model Class
        models.add(modelClassObj);  // we donot use "addAll" because single object at a time is added to "models List"
        });

        subjectsList.assignAll(models);   // assigning all items of models list to subjects list.

        /// "for (var subject in subjectsController.subjectsList)" starts a loop that iterates over each item in "subjectsController.subjectsList". The loop assigns each item to a temporary variable called subject.
        print("final subjectList each item in subjectsController:");
        for (var subject in subjectsList) {
          print("Subject ID: ${subject.id}, Name: ${subject.name}");
        }

      } else if (response.statusCode ==  400 ) {    // this condition works when token is Expired so we need to remove it from local storage

        LogoutController logoutController = Get.put(LogoutController());

        var errrorMessage = "Token expired. Please log in again";

        logoutController.handleLogout();

        throw Exception(errrorMessage);

      } else {
        print('Request failed with status: ${response.statusCode}.');

        print("Response body: ${response.body}");
        var errorMessage = jsonDecode(response.body) ['message'] ?? "Unknown error occurred";
        print("erroMessage: ${errorMessage.toString()}");
        throw Exception(errorMessage);
      }
    } on Exception catch (e) {
      Get.snackbar(
          "Error",
          e.toString(),
          duration: Duration(seconds: 4),
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
