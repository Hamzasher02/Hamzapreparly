import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chaptersModel.dart';
import '../utilities/api_endpoints.dart';

import 'package:http/http.dart' as http;

import '../utilities/internet_check.dart';
import 'logoutController.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();  //creating the instance (_prefs) of sharedPreferences

class ChaptersController extends GetxController {

  RxList<ChaptersModel> chaptersList = RxList<ChaptersModel> ([]);       // Now it doesn't need '.obs' because RxList itself is "Observable"
  var isLoading = true.obs; 
  
  @override
  void onInit() {
    super.onInit();
    
    fetchChapters(); // as soon as this controller is initialized the fetchChapters() function is called
  }
  
  Future<void> fetchChapters () async{   //it is async function because the data comes from API in future
    try{
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
      Uri url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.chapter);

      var response = await http.get(url, headers: headers);

      if(response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        print("chapters Response: ${jsonResponse.toString()}");

        List<ChaptersModel> models = [];

        jsonResponse.forEach((jsonObj) {
          final chapterModelObj = ChaptersModel.fromJson(jsonObj);
          models.add(chapterModelObj);   // adding each element that is converted to dataType of model class to models list
        });

        chaptersList.assignAll(models);

        /// "for (var subject in chaptersController.chaptersList)" starts a loop that iterates over each item in "chaptersController.chaptersList". The loop assigns each item to a temporary variable called 'chapter'.
        print("final chaptersList each item in chaptersController:");
        for(var chapter in chaptersList) {
          print("chapter ID: ${chapter.id}, chapter Name: ${chapter.name}");
        }

      } else if (response.statusCode ==  400 ) {    // this condition works when token is Expired so we need to remove it from local storage

        LogoutController logoutController = Get.put(LogoutController());

        var errrorMessage = "Token expired. Please log in again";

        logoutController.handleLogout();

        throw Exception(errrorMessage);

      } else{
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
          titleText: Text("Notification"),       // will overwrite the 'Error'
          messageText: Text("${e.toString()}"),  //this will overwrite the e.toString() provided above
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