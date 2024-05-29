import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/videosModel.dart';
import '../utilities/api_endpoints.dart';
import '../utilities/internet_check.dart';
import 'logoutController.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();  //creating the instance (_prefs) of sharedPreferences

class VideoController extends GetxController {

  //VideosModel? videoModelObj;

  final videoModelObj = Rx<VideosModel?>(null);  // 'videoModelObj' is an observable object of type Rx<VideosModel?>. The initial value of the object is set to null to avoid garbage value.

  var isLoading = true.obs;

  @override
  void onInit() {
    fetchVideos();
    super.onInit();
  }

  void fetchVideos() async {
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

      Uri url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.video);

      var response = await http.get(url,headers: headers);

      if (response.statusCode == 200) {
        print("printing response.body: ${response.body}");

        var jsonResponse = response.body;
        videoModelObj.value = videosModelFromJson(jsonResponse);

        for (var video in videoModelObj.value!.videoList!) {
          print("Video ID: ${video.id}, Title: ${video.name}, chapterID: ${video.chapterid!.name}");
        }

      }  else if (response.statusCode ==  400 ) {    // this condition works when token is Expired so we need to remove it from local storage

        LogoutController logoutController = Get.put(LogoutController());

        var errrorMessage = "Token expired. Please log in again";

        logoutController.handleLogout();

        throw Exception(errrorMessage);

      } else {
        print('Request failed with status: ${response.statusCode}.');
        print("failed to load videos");

        var errorMessage = jsonDecode(response.body) ['message'] ?? "Unknown error occurred";
        print("erroMessage: ${errorMessage.toString()}");
        throw Exception(errorMessage);
      }
    } on Exception catch (e) {

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
  @override
  void onClose() {
    super.onClose();
  }
}